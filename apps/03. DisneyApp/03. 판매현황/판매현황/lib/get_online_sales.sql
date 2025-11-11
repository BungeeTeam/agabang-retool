WITH
  '{{ var_brand_code.value }}' as brand_code,
  SALE_GB_SALES AS (
    select
        sale_gb,
        sale_dt,
        SUM(SUM(sales_qty)) OVER (PARTITION BY sale_gb ORDER BY sale_dt) AS cum_sale_qty
    from agabang_dw.daily_shop_sales_by_color
    where br_cd = brand_code
    and sty_cd = '{{var_item_info.value.sty_cd}}'
    and col_cd = '{{var_item_info.value.col_cd}}'
    group by 1,2
),
SALE_GB_TREND AS (
  select
        sale_gb,
        arrayMap(
                   (day, val) -> '{"day":"' || toString(day) || '", "val":' || toString(val) || '}',
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
WHERE sale_gb in ('매장판매', '온라인판매')