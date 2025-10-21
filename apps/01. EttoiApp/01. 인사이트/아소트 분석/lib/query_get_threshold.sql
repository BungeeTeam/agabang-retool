WITH
  '07' as brand_code,
  '{{select1.selectedItem.year_cd}}' AS target_year_cd,
  '{{select1.selectedItem.sesn_cd}}' AS target_sesn_cd,
  {{input_target_rate.value / 100}} AS target_sale_rate,
  ('3M', '70', 'FREE', '100', 'Free') AS size_code_1,
  ('6M', '75', '42', '115', '7-8') AS size_code_2,
  ('12M', '80', '44', '125', '9-10') AS size_code_3,
  ('18M', '90', '46', '130', '11-12') AS size_code_4,
  ('2Y', '100', '48', '140', '13-14', '2T') AS size_code_5,
  ('3Y', '110', '50', '150', '15-16', '3T') AS size_code_6,
  ('4Y', '120', '52', '4T') AS size_code_7,
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
      AND A.year_cd = target_year_cd
      AND A.sesn_cd = target_sesn_cd
      AND color_sale_rate >= target_sale_rate
  ) AS A
  WHERE rn = 1  
),
plan AS (
    SELECT DISTINCT
      A.sty_cd AS sty_cd,
      A.col_cd AS col_cd,
      A.size_cd AS size_cd,
      max(toDate(A.plan_date)) AS plan_date,
      sum(A.plan_qty) AS plan_qty
    FROM agabang.plcoszqty AS A
    WHERE 1=1
      AND substring(A.sty_cd, 1, 2) = brand_code
      AND A.comp_cd = 'AG001'
    GROUP BY sty_cd, col_cd, size_cd
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
        C.plan_qty AS plan_qty,
        row_number() OVER (PARTITION BY A.sty_cd, A.col_cd, B.size_cd ORDER BY B.sale_dt DESC) AS rn
      FROM color AS A
      LEFT JOIN agabang_dw.daily_sales_by_size AS B
      ON A.sty_cd = B.sty_cd
        AND A.col_cd = B.col_cd
      LEFT JOIN plan AS C
      ON A.sty_cd = C.sty_cd
        AND A.col_cd = C.col_cd
        AND B.size_cd = C.size_cd
      WHERE 1=1
        AND B.sale_dt <= A.sale_dt
        AND B.br_cd = brand_code
    )
    WHERE 1=1
        AND rn = 1
),
final AS (
  SELECT
    sale_dt,
    sty_cd,
    max(sty_nm) as sty_nm,
    col_cd,
    max(col_nm) as col_nm,
    sum(plan_qty) as color_plan_qty,
    maxIf(plan_qty, size_nm IN size_code_1) as plan_qty_3m,
    maxIf(plan_qty, size_nm IN size_code_2) as plan_qty_6m,
    maxIf(plan_qty, size_nm IN size_code_3) as plan_qty_12m,
    maxIf(plan_qty, size_nm IN size_code_4) as plan_qty_18m,
    maxIf(plan_qty, size_nm IN size_code_5) as plan_qty_2y,
    maxIf(plan_qty, size_nm IN size_code_6) as plan_qty_3y,
    maxIf(plan_qty, size_nm IN size_code_7) as plan_qty_4y,
    max(color_cum_in_qty) as color_cum_in_qty,
    maxIf(size_cum_in_qty, size_nm IN size_code_1) as in_qty_3m,
    maxIf(size_cum_in_qty, size_nm IN size_code_2) as in_qty_6m,
    maxIf(size_cum_in_qty, size_nm IN size_code_3) as in_qty_12m,
    maxIf(size_cum_in_qty, size_nm IN size_code_4) as in_qty_18m,
    maxIf(size_cum_in_qty, size_nm IN size_code_5) as in_qty_2y,
    maxIf(size_cum_in_qty, size_nm IN size_code_6) as in_qty_3y,
    maxIf(size_cum_in_qty, size_nm IN size_code_7) as in_qty_4y,
    sum(in_rate) as tot_in_rate,
    maxIf(in_rate, size_nm IN size_code_1) as in_rate_3m,
    maxIf(in_rate, size_nm IN size_code_2) as in_rate_6m,
    maxIf(in_rate, size_nm IN size_code_3) as in_rate_12m,
    maxIf(in_rate, size_nm IN size_code_4) as in_rate_18m,
    maxIf(in_rate, size_nm IN size_code_5) as in_rate_2y,
    maxIf(in_rate, size_nm IN size_code_6) as in_rate_3y,
    maxIf(in_rate, size_nm IN size_code_7) as in_rate_4y,
    max(color_cum_sale_qty) as color_cum_sale_qty,
    maxIf(size_cum_sale_qty, size_nm IN size_code_1) as sale_qty_3m,
    maxIf(size_cum_sale_qty, size_nm IN size_code_2) as sale_qty_6m,
    maxIf(size_cum_sale_qty, size_nm IN size_code_3) as sale_qty_12m,
    maxIf(size_cum_sale_qty, size_nm IN size_code_4) as sale_qty_18m,
    maxIf(size_cum_sale_qty, size_nm IN size_code_5) as sale_qty_2y,
    maxIf(size_cum_sale_qty, size_nm IN size_code_6) as sale_qty_3y,
    maxIf(size_cum_sale_qty, size_nm IN size_code_7) as sale_qty_4y,
    sum(size_sale_rate_color) as tot_size_sale_rate,
    maxIf(size_sale_rate, size_nm IN size_code_1) as size_sale_rate_3m,
    maxIf(size_sale_rate, size_nm IN size_code_2) as size_sale_rate_6m,
    maxIf(size_sale_rate, size_nm IN size_code_3) as size_sale_rate_12m,
    maxIf(size_sale_rate, size_nm IN size_code_4) as size_sale_rate_18m,
    maxIf(size_sale_rate, size_nm IN size_code_5) as size_sale_rate_2y,
    maxIf(size_sale_rate, size_nm IN size_code_6) as size_sale_rate_3y,
    maxIf(size_sale_rate, size_nm IN size_code_7) as size_sale_rate_4y,
    max(color_sale_rate) as color_sale_rate,
    maxIf(size_sale_rate_color, size_nm IN size_code_1) as size_sale_rate_color_3m,
    maxIf(size_sale_rate_color, size_nm IN size_code_2) as size_sale_rate_color_6m,
    maxIf(size_sale_rate_color, size_nm IN size_code_3) as size_sale_rate_color_12m,
    maxIf(size_sale_rate_color, size_nm IN size_code_4) as size_sale_rate_color_18m,
    maxIf(size_sale_rate_color, size_nm IN size_code_5) as size_sale_rate_color_2y,
    maxIf(size_sale_rate_color, size_nm IN size_code_6) as size_sale_rate_color_3y,
    maxIf(size_sale_rate_color, size_nm IN size_code_7) as size_sale_rate_color_4y
  FROM size
  GROUP BY sale_dt, sty_cd, col_cd
  ORDER BY sty_cd, col_cd
)
SELECT * FROM final