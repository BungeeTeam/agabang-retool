// 기간
const _date = {{input_date_range.value}}
const _date_start = moment(_date.start).format('YYYY-MM-DD')
const _date_end = moment(_date.end).format('YYYY-MM-DD')

// 카테고리
const _category = {{input_category.value}}

let _cat_filter = ''

if(_category && _category !== '전체') {
  _cat_filter = `AND cat_nm = '${_category}'`
}

// 출시 시즌
const _seasons = {{input_season.value
  .map(item => `'${item}'`)
  .join(', ')
}}

// 출산용품 카테고리 재분류
const _maternity = {{def_maternity_code_list.value
  .map(item => `'${item}'`)
  .join(', ')
}}

// 표시 개수
const _limit = {{input_limit.value}}

const _query = `
WITH
    '${_date_start}'::DATE AS start_date,
    '${_date_end}'::DATE AS end_date,
    (${_seasons}) AS target_year_sesn,
    (${_maternity}) AS maternity_code_list,
    ${_limit} AS limit_count,
    date_diff('day', start_date, end_date) + 1 AS period,
    start_date - INTERVAL period DAYS AS start_date_prev,
    end_date - INTERVAL period DAYS AS end_date_prev,
    '07' as brand_code,
md_info AS (
  SELECT DISTINCT A.sty_cd, A.cat_nm
  FROM agabang_dw.retooldb_item_md_info as A
  WHERE A.br_cd=brand_code
),
daily_sales_cur AS (
    SELECT
        A.sty_cd AS sty_cd,
        max(A.sty_nm) AS sty_nm,
        A.col_cd AS col_cd,
        max(A.col_nm) AS col_nm,
        sum(A.sale_qty) AS sale_qty,
        sum(A.sale_amt) AS sale_amt,
        max(A.year_cd) AS year_cd,
        max(A.sesn_cd) AS sesn_cd
    FROM agabang_dw.daily_sales_by_color AS A
    JOIN md_info AS B
    ON A.sty_cd = B.sty_cd
    WHERE 1=1
        AND A.sale_dt BETWEEN start_date AND end_date
        AND concat(A.year_cd, A.sesn_cd) IN target_year_sesn ${_cat_filter}
        AND A.br_cd=brand_code
    GROUP BY sty_cd, col_cd
),
daily_sales_prev AS (
    SELECT
        A.sty_cd AS sty_cd,
        A.col_cd AS col_cd,
        sum(A.sale_qty) AS sale_qty,
        sum(A.sale_amt) AS sale_amt,
        max(A.year_cd) AS year_cd,
        max(A.sesn_cd) AS sesn_cd,
        rank() OVER (ORDER BY sale_qty DESC) AS sale_rank_prev
    FROM agabang_dw.daily_sales_by_color AS A
    JOIN md_info AS B
    ON A.sty_cd = B.sty_cd
    WHERE 1=1
        AND A.sale_dt BETWEEN start_date_prev AND end_date_prev
        AND concat(A.year_cd, A.sesn_cd) IN target_year_sesn ${_cat_filter}
        AND A.br_cd=brand_code
    GROUP BY sty_cd, col_cd
    ORDER BY sale_qty DESC
),
latest_data AS (
    SELECT
        A.sty_cd AS sty_cd,
        A.col_cd AS col_cd,
        A.cum_in_qty AS cum_in_qty,
        A.cum_sale_qty AS cum_sale_qty
    FROM (
        SELECT
            A.*,
            row_number() OVER (PARTITION BY sty_cd, col_cd ORDER BY sale_dt DESC) AS date_ord
        FROM agabang_dw.daily_sales_by_color AS A
        WHERE 1=1
            AND concat(year_cd, sesn_cd) IN target_year_sesn
            AND A.br_cd=brand_code
    ) AS A
    JOIN md_info AS B
    ON A.sty_cd = B.sty_cd
    WHERE 1=1
      AND date_ord = 1 ${_cat_filter}
),
final AS (
    SELECT
        row_number() OVER (ORDER BY sale_qty_cur DESC) AS idx,
        rank() OVER (ORDER BY sale_qty_cur DESC) AS sale_rank,
        A_p.sale_rank_prev AS sale_rank_prev,
        A.sty_cd AS sty_cd,
        A.sty_nm AS sty_nm,
        A.col_cd AS col_cd,
        A.col_nm AS col_nm,
        A.year_cd AS year_cd,
        A.sesn_cd AS sesn_cd,
        CASE
          WHEN D.cat_nm IN maternity_code_list THEN '출산용품'
          ELSE D.cat_nm
        END AS cat_nm,
        C.tag_prce AS tag_prce,
        B.cum_in_qty AS cum_in_qty,
        A.sale_qty AS sale_qty_cur,
        A_p.sale_qty AS sale_qty_prev,
        CASE
            WHEN sale_qty_prev = 0 THEN null
            ELSE (sale_qty_cur - sale_qty_prev) / abs(sale_qty_prev)
        END AS inc_rate,
        B.cum_sale_qty AS cum_sale_qty,
        (cum_sale_qty / nullif(cum_in_qty, 0)) AS tot_sale_rate
    FROM daily_sales_cur AS A
    JOIN daily_sales_prev AS A_p
      ON A.sty_cd = A_p.sty_cd AND A.col_cd = A_p.col_cd
    JOIN latest_data AS B
      ON A.sty_cd = B.sty_cd AND A.col_cd = B.col_cd
    JOIN agabang.plstycd AS C
      ON A.sty_cd = C.sty_cd
    JOIN md_info AS D
      ON A.sty_cd = D.sty_cd
    ORDER BY sale_rank, sale_qty_prev DESC
)
SELECT * FROM final
LIMIT limit_count`

return _query