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
    AND sty_cd = '{{var_sel_sty_info.value.sty_cd}}'
    AND col_cd = '{{var_sel_sty_info.value.col_cd}}'
    -- AND sale_dt BETWEEN addDays(today(), -120) AND today()
  ORDER BY sale_dt
),
-- year_code AS (
--   SELECT
--     year_cd,
--     groupArray(year_cd) OVER (
--         ORDER BY year_nm ASC
--         ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING
--     ) AS year_list
--   FROM (
--     SELECT year_cd, max(year_nm) as year_nm
--     FROM agabang_dw.code_season
--     GROUP BY year_cd
--   )
-- ),
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
    -- D.year_list
  FROM agabang_dw.daily_data_by_color AS A
  JOIN agabang_dw.retooldb_item_md_info AS B
  ON A.sty_cd = B.sty_cd
  JOIN agabang_dw.prod_sales_stock_by_color AS C
  ON A.comp_cd = C.comp_cd AND A.sty_cd = C.sty_cd AND A.col_cd = C.col_cd
  -- JOIN year_code AS D
  -- ON C.year_cd = D.year_cd
  WHERE 1=1
  AND cat_nm = '{{var_sel_sty_info.value.cat_nm}}'
  AND d_date >= 0
  -- AND C.year_cd IN D.year_list
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
  round(B.avg_sale_rate / 100 * A.tot_in_qty) AS avg_sale_qty
FROM raw AS A
LEFT OUTER JOIN avg_rate AS B
ON A.d_date = B.d_date
-- SELECT * FROM year_code