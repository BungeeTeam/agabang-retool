WITH 
  '{{var_brand_code.value }}' as brand_code,
SHOP_IN_TOTAL AS (
    select
        shop_cd,
        shop_nm,
        sty_cd,
        col_cd,
        size_cd,
        sum(out_qty) as total_in_qty
    from agabang_dw.daily_shop_dsoutrtn_by_size
    where br_cd = brand_code
    and sty_cd = '{{ var_item_info.value?.sty_cd }}'
    and col_cd = '{{ var_item_info.value?.col_cd }}'
    group by 1,2,3,4,5
    order by 1,2,3,4,5
),
SHOP_SALES_TOTAL AS (
    select
        shop_cd,
        shop_nm,
        sty_cd,
        col_cd,
        size_cd,
        sum(sales_qty) as total_sale_qty
    from agabang_dw.daily_shop_sales_by_size
    where br_cd = brand_code
    and sty_cd = '{{ var_item_info.value?.sty_cd }}'
    and col_cd = '{{ var_item_info.value?.col_cd }}'
    group by 1,2,3,4,5
    order by 1,2,3,4,5
),
SIZE_SHOP AS (
    SELECT A.shop_cd as shop_cd,
             A.shop_nm as shop_nm,
             A.sty_cd as sty_cd,
             C.sty_nm as sty_nm,
             A.col_cd as col_cd,
             C.col_nm as col_nm,
             A.size_cd as size_cd,
             C.size_nm as size_nm,
             A.total_in_qty as total_in_qty,
             coalesce(B.total_sale_qty, 0) as total_sale_qty,
             round((coalesce(B.total_sale_qty, 0) / A.total_in_qty) * 100, 2) as total_sale_per
    FROM SHOP_IN_TOTAL as A
    LEFT JOIN SHOP_SALES_TOTAL as B
      ON A.shop_cd = B.shop_cd
        AND A.sty_cd = B.sty_cd
        AND A.col_cd = B.col_cd
        AND A.size_cd = B.size_cd
    LEFT JOIN agabang_dw.prod_sales_stock_by_size as C
      ON A.sty_cd = C.sty_cd
        AND A.col_cd = C.col_cd
        AND A.size_cd = C.size_cd
    WHERE C.br_cd = brand_code
)
SELECT
    size_nm,
    count(distinct(case when total_in_qty > 0 then shop_nm else NULL end)) as in_shop_cnt,
    count(distinct(case when total_sale_qty > 0 then shop_nm else NULL end)) sale_shop_cnt,
    '[' || arrayStringConcat(
            arrayMap(
                x -> concat(
                    '{"shop_nm":"', x.1, '",',
                    '"in":', x.2, ',',
                    '"sale":', x.3, '}'
                ),
                arraySort(x -> x.1, groupArray((
                    shop_nm,
                    total_in_qty,
                    total_sale_qty
                )))
            ),
            ','
        ) || ']' AS shop_graph_data
FROM SIZE_SHOP
WHERE ( ({{ shop_sales_table.selectedRowKeys.length }} == 0 ) or ( shop_nm in ({{ shop_sales_table.selectedRowKeys.map(item => `'${item}'`).join(', ') }}) ) )
GROUP BY 1