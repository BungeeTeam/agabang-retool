WITH
  '{{dateRange.value.start}}' AS start_date,
  '{{dateRange.value.end}}' AS end_date,
sale_raw AS (
    SELECT
        A.sty_cd AS sty_cd,
        A.col_cd AS col_cd,
        max(A.sty_nm) AS sty_nm,
        max(A.col_nm) AS col_nm,
        max(A.year_cd) AS year_cd,
        max(A.sesn_cd) AS sesn_cd,
        sum(A.sale_qty) AS sale_qty
    FROM agabang_dw.daily_sales_by_color AS A
    WHERE 1=1
        AND sale_dt BETWEEN start_date AND end_date
        AND concat(A.year_cd, A.sesn_cd) IN ({{var_target_season_code.value}})
        AND A.br_cd = '07'
    GROUP BY A.sty_cd, A.col_cd
),
new_cat_added AS (
    SELECT
        A.*,
        B.cat_nm AS cat_nm,
        CASE
            WHEN B.colab_yn = TRUE THEN B.colab_nm
            WHEN B.cat_nm IN ('출산용품', '침구류', '방수류', '목욕위생류', '완구류', '발육류', '기타') THEN '출산용품'
            WHEN A.sesn_cd = '0' THEN
                (CASE
                    WHEN B.cat_nm IN ('ACC', '기초ACC', '정상ACC', '토들러ACC') THEN 'ACC'
                    WHEN B.cat_nm IN ('기획', '기획외의', '기획내의') THEN '기획'
                    ELSE B.cat_nm
                END)
            ELSE B.cat_nm
        END AS new_cat
    FROM sale_raw AS A
    JOIN agabang_dw.retooldb_item_md_info AS B
      ON A.sty_cd = B.sty_cd
     -- WHERE B.br_cd = '07'
),
dsrealsum AS (
    SELECT
        A.sty_cd AS sty_cd,
        A.col_cd AS col_cd,
        min(CASE WHEN A.wh_cd = '1000' THEN toDate(A.fin_date) ELSE NULL END) AS fin_date,
        min(CASE WHEN A.wh_cd = '1000' THEN toDate(A.fout_date) ELSE NULL END) AS fout_date,
        coalesce(sum(A.in_qty - A.in_rt_qty), 0) AS tot_in_qty,
        coalesce(sum(A.out_qty - A.rtn_qty), 0) AS out_qty
    FROM agabang.dsrealsum AS A
    WHERE 1=1
        AND A.comp_cd = 'AG001'
        AND A.br_cd = '07'
    GROUP BY A.sty_cd, A.col_cd
),
plstycd AS (
    SELECT
        A.sty_cd AS sty_cd,
        max(A.tag_prce) AS tag_prce
    FROM agabang.plstycd AS A
    WHERE 1=1
        AND A.comp_cd = 'AG001'
        AND A.br_cd = '07'
    GROUP BY A.sty_cd
),
slstysum AS (
    SELECT
        A.sty_cd AS sty_cd,
        A.col_cd AS col_cd,
        sum(A.sale_qty) AS tot_sale_qty
    FROM agabang_dw.daily_sales_by_color AS A
    WHERE 1=1
        AND A.comp_cd = 'AG001'
        AND A.sale_dt <= end_date
    GROUP BY A.sty_cd, A.col_cd
),
final_price AS (
    SELECT
        A.sty_cd AS sty_cd,
        A.col_cd AS col_cd,
        max(A.br_cd) as br_cd,
        max(A.final_sale_prce) AS f_sale_prce,
        max(B.cost_prce) AS cost_prce,
        max(B.multi_rate) as multi_rate
    FROM agabang_dw.prod_final_price AS A
    JOIN agabang_dw.prod_sales_stock_by_color as B
      ON A.sty_cd = B.sty_cd
        AND A.col_cd = B.col_cd
    WHERE 1=1
      AND A.br_cd='07'
    GROUP BY A.sty_cd, A.col_cd

    -- SELECT
    --     A.sty_cd AS sty_cd,
    --     A.col_cd AS col_cd,
    --     max(A.final_sale_prce) AS f_sale_prce
    -- FROM agabang_dw.prod_final_price AS A
    -- WHERE 1=1
    --   AND A.br_cd='07'
    -- GROUP BY A.sty_cd, A.col_cd
),
final AS (
    SELECT
        A.new_cat AS new_cat,
        A.sty_cd AS sty_cd,
        A.sty_nm AS sty_nm,
        A.col_cd AS col_cd,
        A.col_nm AS col_nm,
        A.sale_qty AS int_sale_qty,
        A.sale_qty / nullif(B.tot_in_qty, 0) AS int_sale_rate,
        B.tot_in_qty AS tot_in_qty,
        D.tot_sale_qty AS tot_sale_qty,
        C.tag_prce AS tag_prce,
        E.f_sale_prce AS f_sale_prce,
        C.tag_prce / nullif(E.cost_prce*1.1, 0) AS multi_rate,
        B.fin_date AS fin_date,
        B.fout_date AS fout_date
    FROM new_cat_added AS A
    LEFT JOIN dsrealsum AS B
      ON A.sty_cd = B.sty_cd 
        AND A.col_cd = B.col_cd
    LEFT JOIN plstycd AS C
      ON A.sty_cd = C.sty_cd
    LEFT JOIN slstysum AS D
      ON A.sty_cd = D.sty_cd 
          AND A.col_cd = D.col_cd
    LEFT JOIN final_price AS E
      ON A.sty_cd = E.sty_cd 
          AND A.col_cd = E.col_cd
    WHERE A.new_cat IS NOT NULL
      AND E.br_cd='07'
),
best AS (
  SELECT *
  FROM (
      SELECT
          -- row_number() OVER (PARTITION BY new_cat ORDER BY int_sale_qty DESC) AS sale_rank,
          row_number() OVER (PARTITION BY new_cat ORDER BY int_sale_qty DESC, int_sale_rate DESC, tot_sale_qty DESC) AS sale_rank,
          *
      FROM final AS A
      WHERE 1=1
          AND A.int_sale_qty > 0
  )
  WHERE 1=1
      AND sale_rank <= 5
),
worst AS (
            SELECT A.*
  FROM (
      SELECT

          row_number() OVER (PARTITION BY new_cat ORDER BY int_sale_qty ASC, int_sale_rate ASC, tot_sale_qty asc) AS sale_rank,
          *
      FROM final AS A
      WHERE 1=1
          AND tot_sale_qty / nullif(tot_in_qty, 0) < 0.5
          AND date_diff('day', fout_date, today(), 'Asia/Seoul') >= 20
  ) AS A
LEFT JOIN best AS B
  ON A.sty_cd = B.sty_cd AND A.col_cd = B.col_cd
  WHERE 1=1
      AND A.sale_rank <= 5
      AND B.sty_cd IS NULL
  -- SELECT *
  -- FROM (
  --     SELECT
  --         -- row_number() OVER (PARTITION BY new_cat ORDER BY int_sale_qty ASC) AS sale_rank,
  --         row_number() OVER (PARTITION BY new_cat ORDER BY int_sale_qty ASC, int_sale_rate ASC, tot_sale_qty asc) AS sale_rank,
  --         *
  --     FROM final AS A
  --     WHERE 1=1
  --         AND tot_sale_qty / nullif(tot_in_qty, 0) < 0.5
  --         AND date_diff('day', fout_date, today(), 'Asia/Seoul') >= 20
  -- )
  -- WHERE 1=1
  --     AND sale_rank <= 5
  -- EXCEPT
  -- SELECT * FROM best
)
SELECT
  'BEST' AS sort,
  *
FROM best
UNION ALL
SELECT
  'WORST' AS sort,
  *
FROM worst