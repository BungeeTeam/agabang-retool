
WITH
    toDate('{{dateRange.value.start}}') as start_date,
    toDate('{{dateRange.value.end}}') as end_date,
    addYears(start_date, -1) as last_start_date,
    addYears(end_date, -1) as last_end_date,
    YEAR(end_date) as this_yr,
    YEAR(last_start_date) as last_yr,

-- 1. [유지보수성] 복잡한 CASE 로직은 별도의 VIEW로 관리하는 것을 추천합니다.
-- 예: CREATE VIEW agabang_dw.vw_dim_shop AS SELECT ...
CleanedShopDim AS (
    SELECT DISTINCT
        shop_cd, shop_nm, br_cd, br_nm, onoff_flag,
        CASE
            WHEN biz_cd = 'A2' THEN 'A1'
            WHEN br_cd = '79' THEN 'DS'
            ELSE biz_cd
        END as biz_cd,
        CASE
            WHEN biz_nm = '디어베이비사업부' THEN '아가방사업부'
            WHEN br_cd = '79' THEN '디즈니사업부'
            ELSE biz_nm
        END as biz_nm,
        CASE
            WHEN br_cd = '79' AND shop_nm like '%디즈니%' AND shop_nm not like '%팝업%' THEN 'disney_only'
            WHEN br_cd = '79' AND shop_nm like '%디즈니%' AND shop_nm like '%팝업%' THEN 'disney_popup'
            WHEN is_flex = True THEN 'flex'
            ELSE tp_cd
        END as tp_cd,
        CASE
            WHEN br_cd = '79' AND shop_nm like '%디즈니%' AND shop_nm not like '%팝업%' THEN '디즈니단독'
            WHEN br_cd = '79' AND shop_nm like '%디즈니%' AND shop_nm like '%팝업%' THEN '디즈니팝업'
            WHEN is_flex = True THEN '플렉스'
            ELSE tp_nm
        END as tp_nm
    FROM agabang_dw.dim_shop
),

StyleDim AS (
    SELECT DISTINCT -- GROUP BY 대신 DISTINCT 사용으로 가독성 향상
        sty_cd, sty_nm, br_cd, br_nm, sub_br_cd, sub_br_nm,
        it, it_nm, it_gb, it_gb_nm, item, item_nm, tag_price
    FROM agabang_dw.dim_style
    WHERE it in ('6','8')
),

-- 2. [가독성/성능] Raw 데이터 가공 및 집계 기준 컬럼 사전 계산
FactData AS (
    SELECT
        toDate(wrk_dt) as wrk_dt,
        YEAR(toDate(wrk_dt)) as year_unit,
        shop_cd,
        br_cd,
        sty_cd,
        --item,
        -- CASE문을 미리 적용하여 집계 로직을 단순화
        CASE WHEN io_type = 'O' AND rt_yn = 'N' THEN CAST(out_qty AS INT) ELSE 0 END as out_qty,
        CASE WHEN io_type = 'O' AND rt_yn = 'Y' THEN CAST(out_qty AS INT) ELSE 0 END as rt_rtn_qty,
        CASE WHEN io_type = 'R' AND rt_yn = 'Y' THEN CAST(out_qty AS INT) ELSE 0 END as rt_out_qty,
        CASE WHEN io_type = 'O' AND rt_yn = 'N' THEN CAST(sale_prce AS INT) ELSE 0 END as out_amt,
        CASE WHEN io_type = 'O' AND rt_yn = 'Y' THEN CAST(sale_prce AS INT) ELSE 0 END as rt_rtn_amt,
        CASE WHEN io_type = 'R' AND rt_yn = 'Y' THEN CAST(sale_prce AS INT) ELSE 0 END as rt_out_amt
    FROM agabang.dsoutrtn
    -- 3. [성능] WHERE 절에서 함수 사용을 최소화하여 인덱스 활용 유도
    WHERE toDate(wrk_dt) BETWEEN last_start_date AND end_date
      AND substring(item, 1, 1) in ('6','8')
)

-- 최종 집계: 훨씬 간결하고 읽기 쉬워진 구조
SELECT
    -- Shop.biz_cd, Shop.biz_nm,
    -- Style.br_cd as br_cd, Style.br_nm as br_nm,
    Shop.shop_cd as shop_cd, Shop.shop_nm,
    -- Style.sub_br_cd, Style.sub_br_nm,
    -- Shop.tp_cd, Shop.tp_nm,
    -- Style.it_gb, Style.it_gb_nm,
    -- Style.item, Style.item_nm,
    -- Shop.onoff_flag,

    -- 금년 실적
    SUM(CASE WHEN F.year_unit = this_yr THEN F.out_qty ELSE 0 END) as cur_out_qty,
    SUM(CASE WHEN F.year_unit = this_yr THEN F.rt_rtn_qty ELSE 0 END) as cur_rt_rtn_qty,
    SUM(CASE WHEN F.year_unit = this_yr THEN F.rt_out_qty ELSE 0 END) as cur_rt_out_qty,
    SUM(CASE WHEN F.year_unit = this_yr THEN F.out_amt ELSE 0 END) as cur_out_amt,
    SUM(CASE WHEN F.year_unit = this_yr THEN F.rt_rtn_amt ELSE 0 END) as cur_rt_rtn_amt,
    SUM(CASE WHEN F.year_unit = this_yr THEN F.rt_out_amt ELSE 0 END) as cur_rt_out_amt,
    SUM(CASE WHEN F.year_unit = this_yr THEN F.out_qty * Style.tag_price ELSE 0 END) as cur_out_tag,
    SUM(CASE WHEN F.year_unit = this_yr THEN F.rt_rtn_qty * Style.tag_price ELSE 0 END) as cur_rt_rtn_tag,
    SUM(CASE WHEN F.year_unit = this_yr THEN F.rt_out_qty * Style.tag_price ELSE 0 END) as cur_rt_out_tag,

    -- 전년 실적
    SUM(CASE WHEN F.year_unit = last_yr THEN F.out_qty ELSE 0 END) as prev_out_qty,
    SUM(CASE WHEN F.year_unit = last_yr THEN F.rt_rtn_qty ELSE 0 END) as prev_rt_rtn_qty,
    SUM(CASE WHEN F.year_unit = last_yr THEN F.rt_out_qty ELSE 0 END) as prev_rt_out_qty,
    SUM(CASE WHEN F.year_unit = last_yr THEN F.out_amt ELSE 0 END) as prev_out_amt,
    SUM(CASE WHEN F.year_unit = last_yr THEN F.rt_rtn_amt ELSE 0 END) as prev_rt_rtn_amt,
    SUM(CASE WHEN F.year_unit = last_yr THEN F.rt_out_amt ELSE 0 END) as prev_rt_out_amt,
    SUM(CASE WHEN F.year_unit = last_yr THEN F.out_qty * Style.tag_price ELSE 0 END) as prev_out_tag,
    SUM(CASE WHEN F.year_unit = last_yr THEN F.rt_rtn_qty * Style.tag_price ELSE 0 END) as prev_rt_rtn_tag,
    SUM(CASE WHEN F.year_unit = last_yr THEN F.rt_out_qty * Style.tag_price ELSE 0 END) as prev_rt_out_tag

FROM FactData AS F
LEFT JOIN StyleDim AS Style ON F.sty_cd = Style.sty_cd AND F.br_cd = Style.br_cd
LEFT JOIN CleanedShopDim AS Shop ON F.shop_cd = Shop.shop_cd AND F.br_cd = Shop.br_cd
WHERE biz_cd in ({{ bizMultiSelect.value.map(item => `'${item}'`).join(',') }}) 
{{ selectedRow_old.value?.br_nm ? `and Style.br_nm = '${selectedRow_old.value.br_nm}'` : '' }}
{{ selectedRow_old.value?.it_gb_nm ? `and Style.it_gb_nm = '${selectedRow_old.value.it_gb_nm}'` : '' }}
{{ selectedRow_old.value?.item_nm ? `and Style.item_nm = '${selectedRow_old.value.item_nm}'` : '' }}
{{ selectedRow_old.value?.sub_br_nm ? `and Style.sub_br_nm = '${selectedRow_old.value.sub_br_nm}'` : '' }}
and onoff_flag = '오프라인'
GROUP BY
    -- Shop.biz_cd, Shop.biz_nm,
    -- Style.br_cd, Style.br_nm,
    Shop.shop_cd, Shop.shop_nm
    -- Style.sub_br_cd, Style.sub_br_nm,
    -- Shop.tp_cd, Shop.tp_nm,
    -- Style.it_gb, Style.it_gb_nm,
    -- Style.item, Style.item_nm,
    -- Shop.onoff_flag;