WITH
  '{{dateRange.value.start}}' AS start_date,
  '{{dateRange.value.end}}' AS end_date,
sale_raw AS (
    SELECT
        A.sty_cd AS sty_cd,
        max(A.sty_nm) AS sty_nm,
        A.col_cd AS col_cd,
        max(A.col_nm) AS col_nm,
        max(A.year_cd) AS year_cd,
        max(A.sesn_cd) AS sesn_cd,
        sum(A.sale_qty) AS sale_qty,
        sum(A.sale_amt) AS sale_amt
    FROM agabang_dw.daily_sales_by_color AS A
    WHERE 1=1
        AND sale_dt BETWEEN start_date AND end_date
        AND concat(A.year_cd, A.sesn_cd) IN ({{var_target_season_code.value}})
        AND toInt8(A.br_cd) = {{ var_brand_code.value }}
    GROUP BY A.sty_cd, A.col_cd
),
sale_item AS (
    SELECT
        A.*,
        B.item_md_category_id,
        B.cat_raw_nm AS cat_raw_nm,
        B.cat_nm AS cat_nm
    FROM sale_raw AS A
    JOIN agabang_dw.retooldb_item_md_info AS B
      ON A.sty_cd = B.sty_cd
      AND toInt8(B.br_cd) = {{ var_brand_code.value }}
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
        AND toInt8(A.br_cd) = {{ var_brand_code.value }}
    GROUP BY A.sty_cd, A.col_cd
),
plstycd AS (
    SELECT
        A.sty_cd AS sty_cd,
        max(A.tag_prce) AS tag_prce
    FROM agabang.plstycd AS A
    WHERE 1=1
        AND A.comp_cd = 'AG001'
        AND toInt8(A.br_cd) = {{ var_brand_code.value }}
    GROUP BY A.sty_cd
),
slstysum AS (
    SELECT
        A.sty_cd AS sty_cd,
        A.col_cd AS col_cd,
        sum(A.sale_qty) AS tot_sale_qty,
        sum(A.sale_amt) AS tot_sale_amt
    FROM agabang_dw.daily_sales_by_color AS A
    WHERE 1=1
        AND A.comp_cd = 'AG001'
        AND substring(A.sty_cd, 1, 2) = lpad(cast({{ var_brand_code.value }} as text), 2, '0')
        AND A.sale_dt <= end_date
    GROUP BY A.sty_cd, A.col_cd
),
final_price AS (
    SELECT
        A.sty_cd AS sty_cd,
        A.col_cd AS col_cd,
        max(A.dc_rate) AS dc_rate,
        max(A.tag_price) AS tag_price,
        max(A.final_sale_prce) AS f_sale_prce
    FROM agabang_dw.prod_final_price AS A
    WHERE 1=1
      AND substring(A.sty_cd, 1, 2) = lpad(cast({{ var_brand_code.value }} as text), 2, '0')
    GROUP BY A.sty_cd, A.col_cd
),
final AS (
    SELECT
        A.item_md_category_id,
        A.cat_raw_nm AS cat_raw_nm,
        A.cat_nm AS cat_nm,
        -- A.new_cat AS new_cat,
        A.sty_cd AS sty_cd,
        A.sty_nm AS sty_nm,
        A.col_cd AS col_cd,
        A.col_nm AS col_nm,
        A.sale_qty AS int_sale_qty,
        A.sale_amt AS int_sale_amt,
        A.sale_qty / nullif(B.tot_in_qty, 0) AS int_sale_rate,
        B.tot_in_qty AS tot_in_qty,
        D.tot_sale_qty AS tot_sale_qty,
        D.tot_sale_amt AS tot_sale_amt,
        E.tag_price,
        E.dc_rate,
        E.f_sale_prce AS f_sale_prce,
        C.tag_prce / nullif(E.f_sale_prce, 0) AS multi_rate,
        B.fin_date AS fin_date,
        B.fout_date AS fout_date
    -- FROM new_cat_added AS A
    FROM sale_item AS A
    LEFT JOIN dsrealsum AS B
    ON A.sty_cd = B.sty_cd AND A.col_cd = B.col_cd
    LEFT JOIN plstycd AS C
    ON A.sty_cd = C.sty_cd
    LEFT JOIN slstysum AS D
    ON A.sty_cd = D.sty_cd AND A.col_cd = D.col_cd
    LEFT JOIN final_price AS E
    ON A.sty_cd = E.sty_cd AND A.col_cd = E.col_cd
    WHERE A.item_md_category_id = {{ sel_category.value }}
),
best AS (
  SELECT *
  FROM (
      SELECT
          row_number() OVER (PARTITION BY item_md_category_id ORDER BY int_sale_qty DESC) AS sale_rank,
          *
      FROM final AS A
      WHERE 1=1
          AND A.int_sale_qty > 0
  )
  WHERE 1=1
      AND sale_rank <= {{ select_best_list_count.value }}
),
worst AS (
  SELECT *
  FROM (
      SELECT
          row_number() OVER (PARTITION BY item_md_category_id ORDER BY int_sale_qty ASC) AS sale_rank,
          *
      FROM final AS A
      WHERE 1=1
        AND (tot_sale_qty / nullif(tot_in_qty, 0)) < {{ select_exclude_rate.value }} -- tot_sale_qty(누적 판매율), tot_in_qty(입고량)
        AND date_diff('day', fout_date, today(), 'Asia/Seoul') >= {{ select_exclude_day.value }}  -- fout_date(출고일)
          -- AND tot_sale_qty / nullif(tot_in_qty, 0) < 0.5 -- tot_sale_qty(누적 판매율), tot_in_qty(입고량)
          -- AND date_diff('day', fout_date, today(), 'Asia/Seoul') >= 20  -- fout_date(출고일)
  )
  WHERE 1=1
      AND sale_rank <= {{ select_worst_list_count.value }}
  EXCEPT
  SELECT * FROM best
)
SELECT
  'BEST' AS sort,
  *
FROM best
UNION ALL
SELECT
  'WORST' AS sort,
  A.*
FROM worst as A
  -- 베스트에 있는 상품은 워스트에서 제거
LEFT JOIN best AS B 
  ON A.sty_cd = B.sty_cd 
  AND A.col_cd = B.col_cd
WHERE B.sty_cd IS NULL
ORDER BY sale_rank asc;