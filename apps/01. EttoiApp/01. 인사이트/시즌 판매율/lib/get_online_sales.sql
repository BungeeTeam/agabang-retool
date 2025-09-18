WITH
  '{{ var_brand_code.value }}' as brand_code, 
  RAW_SALES AS (
    select
        CASE 
            WHEN sale_gb = '온라인판매' AND shop_cd = '125290' THEN '온라인 - 자사몰'
            WHEN sale_gb = '온라인판매' AND shop_cd != '125290' THEN '온라인 - 외부몰'
            WHEN sale_gb = '매장판매' THEN '오프라인(매장)'
            ELSE sale_gb 
        END AS sale_gb,
        sale_dt,
        SUM(sales_qty) AS sales_qty
    from agabang_dw.daily_shop_sales_by_color
    where br_cd = brand_code
    and sty_cd = '{{ var_item_info.value.sty_cd}}'
    and col_cd = '{{var_item_info.value.col_cd}}'
    group by 1, 2
  ),
  SALE_GB_SALES AS (
    select
        sale_gb,
        sale_dt,
        SUM(SUM(sales_qty)) OVER (PARTITION BY sale_gb ORDER BY sale_dt) AS cum_sale_qty
    from RAW_SALES
    group by 1, 2
),
SALE_GB_TREND AS (
  select
        sale_gb,
        arrayMap(
  (day, val) -> '{"day":"' || toString(day) || '", "val":' || toString(val) || ', "sale_gb":"' || replaceAll(sale_gb, '"', '\\"') || '"}',
  groupArray(sale_dt),
  groupArray(cum_sale_qty)
      ) as sale_trend
    from SALE_GB_SALES
    group by 1
)
SELECT
  sale_gb,   
  concat('[', arrayStringConcat(sale_trend, ','), ']') AS sale_trend
FROM SALE_GB_TREND
WHERE sale_gb in ('오프라인(매장)', '온라인 - 자사몰', '온라인 - 외부몰')
ORDER BY 
  CASE sale_gb 
    WHEN '오프라인(매장)' THEN 1
    WHEN '온라인 - 자사몰' THEN 2
    WHEN '온라인 - 외부몰' THEN 3
    ELSE 4
  END


-- sales_gb 만으로 나눴던 과거 쿼리 (아카이브)
-- WITH
--   '01' as brand_code,
--   SALE_GB_SALES AS (
--     select
--         sale_gb,
--         sale_dt,
--         SUM(SUM(sales_qty)) OVER (PARTITION BY sale_gb ORDER BY sale_dt) AS cum_sale_qty
--     from agabang_dw.daily_shop_sales_by_color
--     where br_cd = brand_code
--     and sty_cd = '{{var_item_info.value.sty_cd}}'
--     and col_cd = '{{var_item_info.value.col_cd}}'
--     group by 1,2
-- ),
-- SALE_GB_TREND AS (
--   select
--         sale_gb,
--         arrayMap(
--                    (day, val) -> '{"day":"' || toString(day) || '", "val":' || toString(val) || '}',
--                    groupArray(sale_dt),
--                    groupArray(cum_sale_qty)
--            ) as sale_trend
--     from SALE_GB_SALES
--     group by 1
-- )
-- SELECT
--   sale_gb,   
--   concat('[', arrayStringConcat(sale_trend, ','), ']') AS sale_trend
-- FROM SALE_GB_TREND
-- WHERE sale_gb in ('매장판매', '온라인판매')