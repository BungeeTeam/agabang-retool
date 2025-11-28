WITH
-- 1. 쿼리 파라미터 정의 (한 곳에서 관리)
query_params AS (
    SELECT
        '{{brandSelect.value}}' as brand_code,               -- 브랜드코드 (디즈니베이비)
        '{{bizSelect.value}}' as biz_code,                 -- 사업부코드
        '{{String.fromCharCode(seasonSelect.selectedItem.year_cd_ly.toUpperCase().charCodeAt(0)+1)}}' as current_year_code,         -- 현재 연도코드 (2025년)
        '{{seasonSelect.selectedItem.year_cd_ly}}' as previous_year_code,        -- 전년 연도코드 (2024년)
        '{{itCodeSelect.value.slice(0,1)}}' as it_code,                   -- 복종대분류코드
        '{{itCodeSelect.value}}' as it_gb_code,           -- 복종중분류코드
        toDate('{{dateRange.value?.start}}') as start_date,       -- 조회 시작일
        toDate('{{dateRange.value?.end}}') as end_date,          -- 조회 종료일
        dateAdd(year, -1, start_date) as prev_start_date,
        dateAdd(year, -1, end_date) as prev_end_date
),

-- 1-1. 시즌코드 파라미터 (IN 절에서 사용하기 위해 별도 테이블로 정의)
season_params AS (
    SELECT '{{ Number(seasonSelect.selectedItem.season_cd) + switchGroup1.value[0] || null}}' as season_code
    UNION ALL
    SELECT '{{ Number(seasonSelect.selectedItem.season_cd) + (switchGroup1.value[1]) || null }}' as season_code
),
shop_handover_mapping AS (
    SELECT DISTINCT
        shop_cd as new_shop_cd,
        shop_nm as new_shop_nm,
        prev_shop_cd,
        prev_shop_nm
    FROM agabang_dw.retooldb_shop_handover
),

warehouse_data AS (
    SELECT
        dsoutrtn.br_cd,
        coalesce(handover.new_shop_cd, dsoutrtn.shop_cd) as shop_cd,


        sum(CASE
            WHEN dsoutrtn.year_cd = p.current_year_code
            THEN CASE WHEN dsoutrtn.io_type = 'O' THEN dsoutrtn.out_qty ELSE dsoutrtn.out_qty * -1 END
            ELSE 0
        END) as out_qty,
        sum(CASE
            WHEN dsoutrtn.year_cd = p.current_year_code
            THEN CASE WHEN dsoutrtn.io_type = 'O' THEN dsoutrtn.sale_prce * dsoutrtn.out_qty ELSE dsoutrtn.sale_prce * dsoutrtn.out_qty * -1 END
            ELSE 0
        END) as out_amt,
        sum(CASE
            WHEN dsoutrtn.year_cd = p.current_year_code
            THEN CASE WHEN dsoutrtn.io_type = 'O' THEN item.tag_price * dsoutrtn.out_qty ELSE item.tag_price * dsoutrtn.out_qty * -1 END
            ELSE 0
        END) as out_tag,


        sum(CASE
            WHEN dsoutrtn.year_cd = p.previous_year_code
            THEN CASE WHEN dsoutrtn.io_type = 'O' THEN dsoutrtn.out_qty ELSE dsoutrtn.out_qty * -1 END
            ELSE 0
        END) as out_qty_ly,
        sum(CASE
            WHEN dsoutrtn.year_cd = p.previous_year_code
            THEN CASE WHEN dsoutrtn.io_type = 'O' THEN dsoutrtn.sale_prce * dsoutrtn.out_qty ELSE dsoutrtn.sale_prce * dsoutrtn.out_qty * -1 END
            ELSE 0
        END) as out_amt_ly,
        sum(CASE
            WHEN dsoutrtn.year_cd = p.previous_year_code
            THEN CASE WHEN dsoutrtn.io_type = 'O' THEN item.tag_price * dsoutrtn.out_qty ELSE item.tag_price * dsoutrtn.out_qty * -1 END
            ELSE 0
        END) as out_tag_ly

    FROM agabang.dsoutrtn as dsoutrtn
    CROSS JOIN query_params p
    LEFT JOIN shop_handover_mapping as handover ON dsoutrtn.shop_cd = handover.prev_shop_cd
    JOIN (
        select
            distinct sty_cd, tag_price
        from agabang_dw.dim_style
        CROSS JOIN query_params p
        where br_cd = brand_code
        and( year_cd = current_year_code or year_cd = previous_year_code)
        and season_cd IN (SELECT season_code FROM season_params WHERE season_code != '')
    ) as item on dsoutrtn.sty_cd = item.sty_cd
    WHERE
        dsoutrtn.br_cd = p.brand_code
        AND dsoutrtn.sesn_cd IN (SELECT season_code FROM season_params WHERE season_code != '')
        AND (
            (dsoutrtn.year_cd = p.current_year_code AND toDate(dsoutrtn.wrk_dt) BETWEEN p.start_date AND p.end_date)
            OR

            (dsoutrtn.year_cd = p.previous_year_code AND toDate(dsoutrtn.wrk_dt) BETWEEN p.prev_start_date AND p.prev_end_date)
        )
        AND CASE WHEN p.it_gb_code = '-1' THEN true ELSE substring(dsoutrtn.item, 1, 1) = p.it_code END
        AND CASE WHEN p.it_code = '5' AND p.it_gb_code = '57' THEN substring(dsoutrtn.item, 1, 2) = '57'
               WHEN p.it_code = '5' AND p.it_gb_code = '5' THEN substring(dsoutrtn.item, 1, 2) != '57'
               ELSE true END
        AND wrk_gb not in ('O12','R12')
    GROUP BY
        dsoutrtn.br_cd, shop_cd
),

sales_data AS (
    SELECT
        sales.shop_cd, sales.shop_nm,
        sales.biz_cd, sales.biz_nm,
        sales.br_cd, sales.br_nm,
        CASE WHEN sales.is_flex = true THEN 'flex' WHEN sales.onoff_flag = '온라인' THEN 'online' ELSE sales.tp_cd END as tp_cd,
        CASE WHEN sales.is_flex = true THEN '플렉스' WHEN sales.onoff_flag = '온라인' THEN '온라인' ELSE sales.tp_nm END as tp_nm,
        sales.onoff_flag,
        sum(CASE WHEN sales.year_cd = p.current_year_code THEN sales.sales_qty ELSE 0 END) as sale_qty,
        sum(CASE WHEN sales.year_cd = p.current_year_code THEN sales.sales_qty * sales.tag_price ELSE 0 END) as sale_tag,
        sum(CASE WHEN sales.year_cd = p.current_year_code THEN sales.sales_price ELSE 0 END) as sale_amt,
        sum(CASE WHEN sales.year_cd = p.previous_year_code THEN sales.sales_qty ELSE 0 END) as sale_qty_ly,
        sum(CASE WHEN sales.year_cd = p.previous_year_code THEN sales.sales_qty * sales.tag_price ELSE 0 END) as sale_tag_ly,
        sum(CASE WHEN sales.year_cd = p.previous_year_code THEN sales.sales_price ELSE 0 END) as sale_amt_ly
    FROM agabang_dw.daily_shop_sales_by_dimension as sales
    CROSS JOIN query_params p
    WHERE
        sales.br_cd = p.brand_code
        AND sales.biz_cd = p.biz_code
        AND sales.season_cd IN (SELECT season_code FROM season_params WHERE season_code != '')
        -- AND sales.team_cd != '60'
        AND (
            (sales.year_cd = p.current_year_code AND sales.sale_dt BETWEEN p.start_date AND p.end_date)
            OR
            -- 미리 계산된 전년 날짜 변수 사용
            (sales.year_cd = p.previous_year_code AND sales.sale_dt BETWEEN p.prev_start_date AND p.prev_end_date)
        )
        AND CASE WHEN p.it_gb_code = '-1' THEN true ELSE sales.it = p.it_code END
        AND CASE WHEN p.it_code = '5' AND p.it_gb_code = '57' THEN sales.it_gb = '57'
               WHEN p.it_code = '5' AND p.it_gb_code = '5' THEN sales.it_gb != '57'
               ELSE true END
    GROUP BY
        sales.shop_cd, sales.shop_nm, sales.biz_cd, sales.biz_nm,
        sales.br_cd, sales.br_nm, tp_cd, tp_nm, sales.onoff_flag
)

SELECT
    s.shop_cd, s.shop_nm, s.biz_cd, s.biz_nm, s.br_cd, s.br_nm, s.tp_cd, s.tp_nm, s.onoff_flag,
    s.sale_qty, s.sale_tag, s.sale_amt,
    COALESCE(w.out_qty, 0) as out_qty,
    COALESCE(w.out_amt, 0) as out_amt,
    COALESCE(w.out_tag, 0) as out_tag,
    s.sale_qty_ly, s.sale_tag_ly, s.sale_amt_ly,
    COALESCE(w.out_qty_ly, 0) as out_qty_ly,
    COALESCE(w.out_amt_ly, 0) as out_amt_ly,
    COALESCE(w.out_tag_ly, 0) as out_tag_ly
FROM sales_data as s
LEFT JOIN warehouse_data as w ON s.br_cd = w.br_cd AND s.shop_cd = w.shop_cd
ORDER BY s.shop_cd;