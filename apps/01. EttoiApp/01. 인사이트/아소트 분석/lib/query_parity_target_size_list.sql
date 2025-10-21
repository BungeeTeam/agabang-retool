WITH 
  '07' as brand_code,
raw AS (
  SELECT DISTINCT
    sty_cd,
    sty_nm,
    col_cd,
    col_nm,
    size_cd,
    size_nm
  FROM agabang_dw.daily_sales_by_size
  WHERE 1=1
    AND concat(sty_cd, col_cd) IN ({{ var_check_parity_list.value == '' ? "''" : var_check_parity_list.value }})
    AND br_cd = brand_code
  ORDER BY 1, 2, 3
)
SELECT
  sty_cd,
  max(sty_nm) AS sty_nm,
  col_cd,
  max(col_nm) AS col_nm,
  groupArray(size_nm) AS size_list
FROM raw
GROUP BY 1, 3