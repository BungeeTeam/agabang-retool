WITH
  -- '2023-06-01' as start_dt,
  -- '2025-03-05' as end_dt,
  -- '01' as selected_br_cd,
  -- 'R' AS selected_yr_cd,
  -- '7' AS selected_season_cd,
  -- '{{ moment(`${season_select.selectedItem.year_nm}-01-01`).subtract(1, 'years').format('YYYY-MM-DD') }}' as start_dt,
-- '{{ date_select.value }}' as end_dt,
-- '{{ season_select.selectedItem.year_cd }}' AS selected_yr_cd,
  '{{ var_clicked_item.value.start_dt }}' as start_dt,
  '{{ var_clicked_item.value.end_dt }}' as end_dt,
  '01' as selected_br_cd,
  '{{ var_clicked_item.value.year_cd }}' AS selected_yr_cd,
  '{{ season_select.selectedItem.sesn_cd }}' AS selected_season_cd,
  '{{ var_clicked_item.value.cat_id }}' AS selected_cat_id,
base_tbl AS (
  SELECT
    A.sty_cd,
    A.sty_nm,
    A.col_cd,
    A.col_nm,
    A.size_cd,
    A.size_nm,
    A.size_tp,
    A.size_seq,
    A.sale_qty_tot,
    A.sale_amt_tot,
    B.tot_in_tag_amt,
    B.tot_in_cost_amt,
    B.tot_in_qty,
    B.tag_price,
    B.it
  FROM (
    SELECT 
      sty_cd, sty_nm, col_cd, col_nm,
      size_cd, size_nm, size_tp, size_seq, 
      sum(sale_qty) as sale_qty_tot,
      SUM(sale_amt) as sale_amt_tot
    FROM agabang_dw.daily_data_by_size
    LEFT JOIN agabang_dw.dim_style as A ON agabang_dw.daily_data_by_size.sty_cd = A.sty_cd and agabang_dw.daily_data_by_size.col_cd = A.col_cd
    WHERE
      sale_dt >= start_dt AND sale_dt <= end_dt
      AND br_cd = selected_br_cd
      AND substring(sty_cd, 5, 1) != '9'
      AND substring(sty_cd, 3, 2) = CONCAT(selected_yr_cd, selected_season_cd)
      AND CASE WHEN selected_cat_id = '999' THEN true
          WHEN selected_cat_id = '666' THEN A.item_md_category_id in ('21','22')
          WHEN selected_cat_id = '777' THEN A.item_md_category_id in ('21','22','20','27')
          WHEN selected_cat_id = '888' THEN A.item_md_category_id in ('24','25')
          ELSE A.item_md_category_id = selected_cat_id END
    GROUP BY sty_cd, sty_nm, col_cd, col_nm, size_cd, size_nm, size_tp, size_seq
  ) as A
  LEFT JOIN (
    SELECT 
      sty_cd, col_cd, size_cd, it,
      SUM(tot_in_tag_amt) as tot_in_tag_amt,
      SUM(tot_in_cost_amt) as tot_in_cost_amt,
      MAX(tot_in_qty) as tot_in_qty,
      MIN(tag_prce) as tag_price
    FROM agabang_dw.prod_sales_stock_by_size
    WHERE br_cd = selected_br_cd
      AND year_cd = selected_yr_cd
      AND sesn_cd = selected_season_cd
      AND it != '9'
      AND case when selected_cat_id = 20 then it = '1'
               when selected_cat_id = 21 then it = '2'
               when selected_cat_id = 22 then it = '3'
               when selected_cat_id = 24 then it = '5'
               when selected_cat_id = 25 then it = '5'
               when selected_cat_id = 26 then it = '6'
               when selected_cat_id = 27 then it = '7'
               when selected_cat_id = 666 then (it in ('2','3'))
               when selected_cat_id = 777 then (it in ('1','2','3','7'))
               when selected_cat_id = 888 then (it in ('5'))
               when selected_cat_id = 999 then (it in ('1','2','3','5','6','7'))
               else false end 
    GROUP BY sty_cd, col_cd, size_cd, it
  ) as B
  ON A.sty_cd = B.sty_cd
  AND A.col_cd = B.col_cd
  AND A.size_cd = B.size_cd
),
base_tbl_agg AS (
  SELECT
    sty_cd,
    sty_nm,
    col_cd,
    col_nm,
    it,
    SUM(tot_in_qty)              AS tot_in_qty,
    SUM(sale_qty_tot)            AS tot_sale_qty,
    MIN(tag_price)               AS tag_price,
    SUM(tot_in_tag_amt)          AS tot_in_tag_amt,
    SUM(sale_amt_tot)            AS tot_sale_amt,
    SUM(tot_in_cost_amt)         AS tot_in_cost_amt

    -- 10,60,10
    -- sum(case when size_cd='10' and size_tp='10' then sale_qty
    --          else 0 end) as sale_qty_60,    -- 60
    -- max(case when size_cd='10' and size_tp='10' then tot_in_qty
    --          else 0 end) as tot_in_qty_60
    
  FROM base_tbl
  GROUP BY sty_cd, sty_nm, col_cd, col_nm, it
),
base_tbl_size_agg AS (
  SELECT
      sty_cd,
      col_cd,
      toJSONString(groupArray((size_cd, size_nm, size_seq, tot_in_qty, sale_qty_tot))) AS size_array
  FROM base_tbl
  GROUP BY sty_cd, col_cd
),
shop_tbl as (
  SELECT
    sty_cd, col_cd, shop_cd, sale_gb, SUM(sales_qty) AS shop_sales_qty
  FROM agabang_dw.daily_shop_sales_by_color 
  WHERE
    sale_dt >= start_dt AND sale_dt <= end_dt
    AND br_cd = selected_br_cd
    AND substring(sty_cd, 5, 1) != '9'
    AND substring(sty_cd, 3, 2) = CONCAT(selected_yr_cd, selected_season_cd)
  GROUP BY sty_cd, col_cd, shop_cd, sale_gb
),
shop_online as (
  SELECT
    sty_cd, col_cd,
    SUM(case when sale_gb = '온라인판매' then shop_sales_qty else 0 end) as online_sale_qty,
    SUM(case when sale_gb = '매장판매' then shop_sales_qty else 0 end) as offline_sale_qty
  FROM shop_tbl
  GROUP BY sty_cd, col_cd
),
shop_gini as (
  SELECT
    sty_cd, col_cd, ROUND(1 - 2 * SUM((rank - 0.5) * shop_sales_ratio) / COUNT(), 4) AS gini
  FROM (
    SELECT 
      sty_cd, col_cd, shop_cd, shop_sales_qty,
      shop_sales_qty / SUM(shop_sales_qty) OVER (PARTITION BY sty_cd, col_cd) AS shop_sales_ratio,
      ROW_NUMBER() OVER (PARTITION BY sty_cd, col_cd ORDER BY shop_sales_qty DESC) AS rank
    FROM (
      SELECT
        sty_cd, col_cd, shop_cd, SUM(shop_sales_qty) AS shop_sales_qty
      FROM shop_tbl
      GROUP BY sty_cd, col_cd, shop_cd
    )
  )
  GROUP BY sty_cd, col_cd
)
SELECT 
  A.sty_cd as sty_cd,
  A.sty_nm,
  A.col_cd as col_cd,
  A.col_nm,
  A.it,
  tot_in_qty,
  tot_sale_qty,
  tot_in_qty - tot_sale_qty as tot_inventory,
  tot_sale_qty / tot_in_qty as qty_sales_ratio,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(A.tot_sale_qty / A.tot_in_qty, 2) ELSE NULL END AS sale_per_tot,
  gini as gini,
  online_sale_qty / tot_sale_qty as online_sales_ratio,
  size_array,
  tag_price,
  tot_in_tag_amt,
  tot_sale_amt,
  tot_sale_amt / tot_in_tag_amt as amt_sales_ratio,
  tot_sale_amt / tot_in_cost_amt as return_ratio
FROM base_tbl_agg as A
LEFT JOIN base_tbl_size_agg as B
  ON A.sty_cd = B.sty_cd AND A.col_cd = B.col_cd
LEFT JOIN shop_online as C
  ON A.sty_cd = C.sty_cd AND A.col_cd = C.col_cd
LEFT JOIN shop_gini as D
  ON A.sty_cd = D.sty_cd AND A.col_cd = D.col_cd
order by qty_sales_ratio asc