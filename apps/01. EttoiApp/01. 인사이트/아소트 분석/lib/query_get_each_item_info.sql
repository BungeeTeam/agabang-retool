WITH
  '07' as brand_code,
  '{{table_main.selectedSourceRow.sty_cd}}' AS target_sty_cd,
  '{{table_main.selectedSourceRow.col_cd}}' AS target_col_cd,
  {{input_target_rate.value / 100}} AS target_sale_rate,
  ('3M', '70', 'FREE', '100') AS size_code_1,
  ('6M', '75', '42', '115', '7-8') AS size_code_2,
  ('12M', '80', '44', '125', '9-10') AS size_code_3,
  ('18M', '90', '46', '130', '11-12') AS size_code_4,
  ('2Y', '100', '48', '140', '13-14') AS size_code_5,
  ('3Y', '110', '50', '150', '15-16') AS size_code_6,
  ('4Y', '120', '52') AS size_code_7,
color AS (
  SELECT
    A.sale_dt AS sale_dt,
    A.sty_cd AS sty_cd,
    A.sty_nm AS sty_nm,
    A.col_cd AS col_cd,
    A.col_nm AS col_nm,
    A.cum_in_qty AS color_cum_in_qty,
    A.cum_sale_qty AS color_cum_sale_qty,
    A.color_sale_rate AS color_sale_rate
  FROM (
    SELECT
      *,
      row_number() over (
        partition by sty_cd, col_cd
        order by sale_dt asc
      ) AS rn,
      cum_sale_qty / nullif(cum_in_qty, 0) AS color_sale_rate
    FROM agabang_dw.daily_sales_by_color AS A
    WHERE 1=1
      AND A.br_cd = brand_code
      AND A.sty_cd = target_sty_cd
      -- AND A.col_cd = target_col_cd
      AND color_sale_rate >= target_sale_rate
  ) AS A
  WHERE rn = 1  
),
size AS (
    SELECT *
    FROM (
      SELECT
        A.sale_dt AS sale_dt,
        A.sty_cd AS sty_cd,
        A.sty_nm AS sty_nm,
        A.col_cd AS col_cd,
        A.col_nm AS col_nm,
        B.size_cd AS size_cd,
        B.size_nm AS size_nm,
        A.color_cum_in_qty AS color_cum_in_qty,
        A.color_cum_sale_qty AS color_cum_sale_qty,
        A.color_sale_rate AS color_sale_rate,
        B.cum_in_qty AS size_cum_in_qty,
        A.color_cum_sale_qty AS color_cum_sale_qty,
        B.cum_sale_qty AS size_cum_sale_qty,
        size_cum_sale_qty / nullif(size_cum_in_qty, 0) AS size_sale_rate,
        size_cum_sale_qty / nullif(color_cum_sale_qty, 0) AS size_sale_rate_color,
        size_cum_in_qty / nullif(color_cum_in_qty, 0) AS in_rate,
        row_number() OVER (PARTITION BY A.sty_cd, A.col_cd, B.size_cd ORDER BY B.sale_dt ASC) AS rn
      FROM color AS A
      LEFT JOIN agabang_dw.daily_sales_by_size AS B
      ON A.sty_cd = B.sty_cd
        AND A.col_cd = B.col_cd
      WHERE 1=1
        AND B.sale_dt >= A.sale_dt
        AND B.br_cd = brand_code
    )
    WHERE 1=1
        AND rn = 1
)
SELECT * FROM size