WITH sale_rate_raw AS (
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
  AND B.cat_nm = '{{var_item_info.value.cat_nm}}'
  AND d_date BETWEEN 0 AND 180
)
SELECT
  d_date,
  avg(sale_rate) AS avg_sale_rate
FROM sale_rate_raw
GROUP BY 1
ORDER BY d_date