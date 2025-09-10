WITH raw AS (
  SELECT
      A.sale_dt,
      B.fout_date,
      A.sale_dt - B.fout_date AS d_date,
      A.sty_cd,
      A.in_qty,
      B.tot_in_qty,
      A.out_qty,
      A.sale_qty,
      sum(A.in_qty) OVER (
          PARTITION BY A.sty_cd
          ORDER BY A.sale_dt
          ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      ) AS in_cumsum,
      sum(A.sale_qty) OVER (
          PARTITION BY A.sty_cd
          ORDER BY A.sale_dt
          ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      ) AS sale_cumsum
  FROM agabang_dw.daily_sales_by_color AS A
  JOIN agabang_dw.prod_sales_stock_by_color AS B
  ON A.sty_cd = B.sty_cd AND A.col_cd = B.col_cd
  WHERE 1=1
    AND sty_cd = '{{sel_sty.value?.sty_cd }}'
    AND col_cd = '{{sel_sty.value?.col_cd }}'
    
  ORDER BY sale_dt
),

avg AS (
  SELECT
    A.sty_cd,
    A.sty_nm,
    A.col_cd,
    B.cat_nm,
    C.item,
    A.sale_dt,
    A.in_qty,
    A.sale_qty,
    sum(A.sale_qty) OVER (
        PARTITION BY A.sty_cd
        ORDER BY A.sale_dt
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS sale_cumsum,
    C.tot_in_qty,
    round(sale_cumsum / C.tot_in_qty * 100, 2) AS sale_rate,
    C.fin_date,
    C.fout_date,
    A.sale_dt - C.fout_date AS d_date
    
  FROM agabang_dw.daily_data_by_color AS A
  JOIN agabang_dw.retooldb_item_md_info AS B
  ON A.sty_cd = B.sty_cd
  JOIN agabang_dw.prod_sales_stock_by_color AS C
  ON A.comp_cd = C.comp_cd AND A.sty_cd = C.sty_cd AND A.col_cd = C.col_cd
  
  
  WHERE 1=1
  AND cat_nm = '{{sel_sty.value?.cat_nm}}'
  AND d_date >= 0
  ORDER BY d_date
),
avg_rate AS (
  SELECT
    d_date,
    least(100, avg(sale_rate)) AS avg_sale_rate
  FROM avg
  GROUP BY 1
  ORDER BY d_date
)
SELECT
  A.*,
  CASE WHEN B.avg_sale_rate / 100 = 1 THEN null
     ELSE round(B.avg_sale_rate / 100 * A.tot_in_qty ) END AS avg_sale_qty
FROM raw AS A
LEFT OUTER JOIN avg_rate AS B
ON A.d_date = B.d_date
ORDER BY d_date