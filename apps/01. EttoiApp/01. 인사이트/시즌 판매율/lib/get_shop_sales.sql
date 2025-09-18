WITH 
  '{{ var_brand_code.value }}' as brand_code, 
  SHOP_IN AS (
    select
        shop_cd,
        shop_nm,
        sty_cd,
        col_cd,
        wrk_dt,
        SUM(SUM(out_qty)) OVER (PARTITION BY shop_cd ORDER BY wrk_dt) AS cum_in_qty
    from agabang_dw.daily_shop_dsoutrtn_by_size
    where br_cd = brand_code
    and sty_cd = '{{var_item_info.value.sty_cd}}'
    and col_cd = '{{var_item_info.value.col_cd}}'
    group by 1,2,3,4,5
),
SHOP_IN_TOTAL AS (
    select
        shop_cd,
        shop_nm,
        sty_cd,
        col_cd,
        sum(out_qty) as total_in_qty
    from agabang_dw.daily_shop_dsoutrtn_by_size
    where br_cd = brand_code
    and sty_cd = '{{var_item_info.value.sty_cd}}'
    and col_cd = '{{var_item_info.value.col_cd}}'
    group by 1,2,3,4
),
SHOP_SALES AS (
    select
        shop_cd,
        shop_nm,
        sty_cd,
        col_cd,
        sale_dt,
        SUM(SUM(sales_qty)) OVER (PARTITION BY shop_cd ORDER BY sale_dt) AS cum_sale_qty
    from agabang_dw.daily_shop_sales_by_color
    where br_cd = brand_code
    and sty_cd = '{{var_item_info.value.sty_cd}}'
    and col_cd = '{{var_item_info.value.col_cd}}'
    group by 1,2,3,4,5
),
SHOP_SALES_TOTAL AS (
    select
        shop_cd,
        shop_nm,
        sty_cd,
        col_cd,
        sum(sales_qty) as total_sale_qty
    from agabang_dw.daily_shop_sales_by_color
    where br_cd = brand_code
    and sty_cd = '{{var_item_info.value.sty_cd}}'
    and col_cd = '{{var_item_info.value.col_cd}}'
    group by 1,2,3,4
),
SHOP_IN_TREND AS (
    select
        shop_cd,
        shop_nm,
        sty_cd,
        col_cd,
        arrayMap(
                   (day, val) -> '{"day":"' || toString(day) || '", "val":' || toString(val) || '}',
                   groupArray(wrk_dt),
                   groupArray(cum_in_qty)
           ) as in_trend
    from SHOP_IN
    group by 1,2,3,4
),
SHOP_SALES_TREND AS (
    select
        A.shop_cd as shop_cd,
        A.shop_nm as shop_nm,
        A.sty_cd as sty_cd,
        A.col_cd as col_cd,
        arrayMap(
                   (day, val) -> '{"day":"' || toString(day) || '", "val":' || toString(val) || '}',
                   groupArray(sale_dt),
                   groupArray(A.cum_sale_qty)
           ) as sale_trend,
        arrayMap(
                   (day, val) -> '{"day":"' || toString(day) || '", "val":' || toString(val) || '}',
                   groupArray(sale_dt),
                   groupArray(round((A.cum_sale_qty/B.total_in_qty)*100,2))
           ) as sale_per_trend
    from SHOP_SALES as A
    JOIN SHOP_IN_TOTAL as B
    on A.shop_cd = B.shop_cd
    group by 1,2,3,4
)
SELECT
    A.shop_cd as shop_cd,
    A.shop_nm as shop_nm,
    A.sty_cd as sty_cd,
    A.col_cd as col_cd,
    A.total_in_qty as total_in_qty,
    B.total_sale_qty as total_sale_qty,
    round((B.total_sale_qty/A.total_in_qty)*100, 2) as total_sale_per,  
    concat('[', arrayStringConcat(C.in_trend, ','), ']') AS in_trend,
    concat('[', arrayStringConcat(D.sale_trend, ','), ']') AS sale_trend,
    concat('[', arrayStringConcat(D.sale_per_trend, ','), ']') AS sale_per_trend
FROM SHOP_IN_TOTAL as A
JOIN SHOP_SALES_TOTAL as B
ON A.shop_cd = B.shop_cd
AND A.sty_cd = B.sty_cd
AND A.col_cd = B.col_cd
JOIN SHOP_IN_TREND as C
ON A.shop_cd = C.shop_cd
AND A.sty_cd = C.sty_cd
AND A.col_cd = C.col_cd
JOIN SHOP_SALES_TREND as D
ON A.shop_cd = D.shop_cd
AND A.sty_cd = D.sty_cd
AND A.col_cd = D.col_cd
ORDER BY 6 desc;