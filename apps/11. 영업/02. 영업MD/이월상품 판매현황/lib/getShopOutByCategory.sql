
WITH
    toDate('{{p_endDate}}') as endDate, --판매 마감일
    toDate('{{ p_seasonEndDate }}') as seasonEndDate, -- 전년도 시즌 종료일: 출고 시작일
    toDate('{{ p_outEndDate }}') as outEndDate, -- 출고 마감일
    '{{ brandMultiSelect2.value }}' as brand_code,
    '{{ yearSelect2.selectedItem.season_cd }}' as season_code,
    '{{ bizMultiSelect2.value }}' as biz_code,
({{ p_year_codes }}) as year_code,
[{{ p_year_codes }}] as year_code_array,


      shopBase as(
            SELECT
                distinct biz_cd,biz_nm,
                         br_cd, br_nm,
                         shop_cd, shop_nm,
                         gb_cd, gb_nm,
                         tp_cd, tp_nm,
                         team_cd, team_nm,
                         onoff_flag
            FROM agabang_dw.dim_shop
            WHERE 
                biz_cd in (biz_code)
                and br_cd in (brand_code)
        ),
    itemBase as(
           SELECT
            sty_cd, sty_nm,
            col_cd, col_nm,
            size_cd, size_nm,
            tag_price, cost_price,
            br_cd, br_nm,
            year_nm, year_cd,
            season_cd, season_nm,
           CASE WHEN year_cd = year_code_array[1] THEN 'B'
                WHEN year_cd = year_code_array[2] THEN 'C'
                WHEN year_cd = year_code_array[3] THEN 'D'
               ELSE 'under D' END as item_grade,
           CASE WHEN it = '1' THEN '시즌언더'
    WHEN it = '2' THEN '시즌의류(B)'
    WHEN it = '3' THEN '시즌의류(T)'
    WHEN it = '4' THEN '파자마'
    WHEN it = '5' AND it_gb = '57' THEN '기획언더'
    WHEN it = '5' THEN '기획의류'
    WHEN it = '6' THEN '위탁용품'
    WHEN it = '7' THEN '시즌용품'
    WHEN it = '8' THEN '일반용품'
    WHEN it = '9' THEN '판촉부자재'
  ELSE '기타' END AS category_name,
          CASE WHEN it = '1' THEN '2'
    WHEN it = '2' THEN '0'
    WHEN it = '3' THEN '1'
    WHEN it = '4' THEN '3'
    WHEN it = '5' AND it_gb = '57' THEN '6'
    WHEN it = '5' THEN '5'
    WHEN it = '6' THEN '7'
    WHEN it = '7' THEN '4'
    WHEN it = '8' THEN '8'
    WHEN it = '9' THEN '9'
  ELSE '기타' END AS category_order
        FROM agabang_dw.dim_style
        WHERE 
            year_cd in year_code
            and it in ('1','2','3','4','5','7')
            and br_cd in (brand_code)
            and season_cd = season_code
        ),
    outBase as (
        SELECT
            wrk_dt, io_type, rt_yn,
            -- COALESCE(D.new_shop_cd, A.shop_cd) as shop_cd,
            shop_cd,
            sty_cd, col_cd, size_cd,
            out_qty, sale_prce, sup_amt,
            br_cd, year_cd, sesn_cd, item,
            -- 기간 구분을 위한 플래그
            CASE WHEN toDate(wrk_dt) BETWEEN seasonEndDate AND outEndDate THEN 1 ELSE 0 END as net_period_flag,
            CASE WHEN toDate(wrk_dt) BETWEEN seasonEndDate AND endDate THEN 1 ELSE 0 END as ttl_period_flag
        FROM agabang.dsoutrtn as A
        -- LEFT JOIN (
        --                   SELECT
        --                       DISTINCT shop_cd as new_shop_cd, shop_nm as new_shop_nm, prev_shop_cd, prev_shop_nm
        --                   FROM agabang_dw.retooldb_shop_handover
        --             ) AS D
        --             ON A.shop_cd = D.prev_shop_cd
        WHERE
           toDate(wrk_dt) BETWEEN seasonEndDate AND greatest(endDate, outEndDate)
          AND year_cd IN year_code_array
          AND substring(sty_cd,5,1) IN ('1','2','3','4','5','7')
         AND wrk_gb not in ('R1','R12','O12') -- R1: 시즌 종료로 인한 반품 제거 / R12, O12: 정산이동으로 인한 출고반품 제거
          AND (br_cd = brand_code OR sty_cd IN (SELECT sty_cd from agabang_dw.retooldb_disney_style))
          AND sesn_cd = season_code
    )

    SELECT
        A.biz_cd as biz_cd,
        A.biz_nm as biz_nm,
        D.br_cd as br_cd,
        D.br_nm as br_nm,
        A.shop_cd as shop_cd,
        A.shop_nm as shop_nm,
        A.tp_cd as tp_cd,
        A.tp_nm as tp_nm,
        D.year_cd as year_cd,
        D.year_nm as year_nm,
        D.season_cd as season_cd,
        D.season_nm as season_nm,
        A.onoff_flag as onoff_flag,
        concat(D.year_cd,D.season_cd) as year_season_cd,
        D.item_grade, D.category_name, D.category_order,
        -- sum(CASE WHEN C.io_type = 'O' and rt_yn='N' THEN C.out_qty ELSE 0 END) as net_out_qty,
        -- sum(CASE WHEN C.io_type = 'O' THEN C.sale_prce*C.out_qty ELSE (-1)*C.sale_prce*C.out_qty END) as net_out_amt,
        -- sum(CASE WHEN C.io_type = 'O' THEN C.out_qty*D.tag_price ELSE (-1)*C.out_qty*D.tag_price END) as net_out_tag
    sum(CASE WHEN C.net_period_flag = 1 THEN
        CASE WHEN C.io_type = 'O' THEN C.out_qty ELSE -C.out_qty END
        ELSE 0 END) as net_out_qty,
    sum(CASE WHEN C.net_period_flag = 1 THEN
        CASE WHEN C.io_type = 'O' THEN C.sale_prce * C.out_qty ELSE C.sale_prce * C.out_qty * (-1) END
        ELSE 0 END) as net_out_amt,
    sum(CASE WHEN C.net_period_flag = 1 THEN
        CASE WHEN C.io_type = 'O' THEN C.out_qty * D.tag_price ELSE C.out_qty * D.tag_price * (-1) END
        ELSE 0 END) as net_out_tag,
              SUM(
            CASE WHEN C.ttl_period_flag = 1 THEN
            CASE WHEN C.io_type = 'O' THEN C.out_qty ELSE 0 END
            ELSE 0 END) as ttl_out_qty,
          SUM(CASE WHEN C.ttl_period_flag = 1 THEN
            CASE WHEN C.io_type = 'R' THEN C.out_qty ELSE 0 END
            ELSE 0 END) as ttl_rtn_qty,
          SUM(CASE WHEN C.ttl_period_flag = 1 THEN
            CASE WHEN C.io_type = 'O' THEN C.sale_prce*C.out_qty ELSE 0 END
            ELSE 0 END) as ttl_out_amt,
          SUM(CASE WHEN C.ttl_period_flag = 1 THEN
            CASE WHEN C.io_type = 'R' THEN C.sale_prce*C.out_qty ELSE 0 END
            ELSE 0 END) as ttl_rtn_amt,
          SUM(CASE WHEN C.ttl_period_flag = 1 THEN
            CASE WHEN C.io_type = 'O' THEN C.out_qty*D.tag_price ELSE 0 END
            ELSE 0 END) as ttl_out_tag,
          SUM(CASE WHEN C.ttl_period_flag = 1 THEN
            CASE WHEN C.io_type = 'R' THEN C.out_qty*D.tag_price ELSE 0 END
            ELSE 0 END) as ttl_rtn_tag
    FROM outBase as C
    LEFT JOIN shopBase as A ON A.shop_cd = C.shop_cd
    LEFT JOIN itemBase as D ON C.sty_cd = D.sty_cd and C.col_cd = D.col_cd and C.size_cd = D.size_cd
    GROUP BY D.item_grade, D.category_name, D.category_order,
            A.biz_cd, A.biz_nm,
            D.br_cd, D.br_nm,
            A.shop_cd, A.shop_nm,
            A.tp_cd, A.tp_nm,
            D.year_cd, D.year_nm,
            D.season_cd, D.season_nm,
            A.onoff_flag;