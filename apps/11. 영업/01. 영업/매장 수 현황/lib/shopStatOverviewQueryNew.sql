WITH
    tbl as (
  SELECT
    t1.sales_yr as sales_yr,
    t2.shop_cd as shop_cd,
    t2.shop_nm as shop_nm,
    YEAR(t2.open_dt) as open_yr,
    t2.open_dt as open_dt,
    YEAR(t2.close_dt) as close_yr,
    t2.close_dt as close_dt,
    t2.tp_cd as tp_cd,
    t2.tp_nm as tp_nm,
    t1.sales_price as sales_price
  FROM (
  
      SELECT
        YEAR(sale_dt) as sales_yr,
        biz_cd,
        br_cd,
        shop_cd,
        sales_price
      FROM agabang_dw.daily_shop_sales_by_dimension
      WHERE YEAR(sale_dt) > YEAR(today()) - 3
        AND date_format(sale_dt, '%m-%d') <= date_format(DATE '{{referenceDate.value }}' , '%m-%d')
  ) as t1
  LEFT JOIN (
    SELECT DISTINCT
        coalesce(handover.shop_cd, shop_cd) as shop_cd ,
        shop_nm,
        CASE WHEN br_cd = '79' THEN 'DS' ELSE biz_cd END as biz_cd,
        CASE WHEN br_cd = '79' THEN '디즈니사업부' ELSE biz_nm END as biz_nm,
        br_cd, br_nm,
        open_dt, close_dt,
        onoff_flag,
        CASE WHEN is_flex = true THEN '플렉스'
            WHEN br_cd = '79' AND shop_nm like '%디즈니%' AND shop_nm not like '%팝업%' THEN '디즈니단독'
            WHEN br_cd = '79' AND shop_nm like '%디즈니%' AND shop_nm like '%팝업%' THEN '디즈니팝업'
            ELSE tp_cd END as tp_cd,
        CASE WHEN is_flex = true THEN '플렉스'
            WHEN br_cd = '79' AND shop_nm like '%디즈니%' AND shop_nm not like '%팝업%' THEN '디즈니단독'
            WHEN br_cd = '79' AND shop_nm like '%디즈니%' AND shop_nm like '%팝업%' THEN '디즈니팝업'
            ELSE tp_nm END as tp_nm,
        area_cd, area_nm,
        team_cd, team_nm,
        user_cd, user_nm
    FROM agabang_dw.dim_shop
    left JOIN agabang_dw.retooldb_shop_handover as handover on dim_shop.shop_cd = handover.prev_shop_cd
    WHERE onoff_flag = '오프라인' AND team_cd != '60'
  ) as t2
  ON t1.shop_cd = t2.shop_cd AND t1.br_cd = t2.br_cd
  WHERE t1.biz_cd = '{{ bizDivSelect.value }}'
)
SELECT
  shop_cd,
  max(shop_nm) as shop_nm,
  sales_yr,
  min(open_yr) as open_yr,
  max(close_yr) as close_yr,
  min(open_dt) as open_dt,
  max(close_dt) as close_dt,
  sum(sales_price) as rev,
  max(tp_cd) as tp_cd,
  max(tp_nm) as tp_nm
FROM tbl
GROUP BY shop_cd, sales_yr
ORDER BY 3 asc,8 desc
;


-- WITH
--     tbl as (
--   SELECT
--     t1.sales_yr as sales_yr,
--     t2.shop_cd as shop_cd,
--     t2.new_shop_cd as new_shop_cd,
--     t2.shop_nm as shop_nm,
--     YEAR(t2.open_dt) as open_yr,
--     t2.open_dt as open_dt,
--     YEAR(t2.close_dt) as close_yr,
--     t2.close_dt as close_dt,
--     t2.area_nm as area_nm,
--     t1.sales_price as sales_price
--   FROM (
--       SELECT
--         YEAR(sale_dt) as sales_yr,
--         br_cd,
--         shop_cd,
--         sales_price
--       FROM agabang_dw.daily_shop_sales_by_style
--       WHERE YEAR(sale_dt) > YEAR(today()) - 3
--         AND date_format(sale_dt, '%m-%d') <= date_format(DATE '{{referenceDate.value }}' , '%m-%d')
--   ) as t1
--   LEFT JOIN (
--     SELECT DISTINCT shop_cd, coalesce(handover.shop_cd, shop_cd) as new_shop_cd , shop_nm, biz_cd, br_cd,
--                     open_dt, close_dt, onoff_flag, tp_cd, tp_nm, area_cd, area_nm,
--                     team_cd, team_nm, user_cd, user_nm
--     FROM agabang_dw.dim_shop
--     left JOIN agabang_dw.retooldb_shop_handover as handover on dim_shop.shop_cd = handover.prev_shop_cd
--     WHERE biz_cd = '{{ bizDivSelect.value }}' AND onoff_flag = '오프라인' AND team_cd != '60'
--   ) as t2
--   ON t1.shop_cd = t2.shop_cd AND t1.br_cd = t2.br_cd
--   WHERE t2.biz_cd IS NOT NULL
-- )
-- SELECT
--   new_shop_cd, -- 인수인계된 매장의 신규 매장 코드로 기존 매장 정보 합산하기 위함
--   max(shop_nm) as shop_nm,
--   sales_yr,
--   min(open_yr) as open_yr,
--   max(close_yr) as close_yr,
--   min(open_dt) as open_dt,
--   max(close_dt) as close_dt,
--   sum(sales_price) as rev,
--   max(area_nm) as area_nm
-- FROM tbl
-- GROUP BY new_shop_cd, sales_yr
-- ORDER BY 3 asc,8 desc
-- ;