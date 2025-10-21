WITH'{{ brand_code.value }}' as brand_code
SELECT
  A.in_dt,
  A.sty_cd,
  B.sty_nm,
  A.col_cd,
  B.col_nm,
  A.size_cd,
  B.size_nm,
  A.in_qty,
  B.tot_in_qty,
  B.tot_sale_qty,
  round(B.tot_sale_qty/B.tot_in_qty,2) as sale_per
FROM agabang_dw.daily_dsin as A
JOIN agabang_dw.prod_sales_stock_by_size as B
ON A.sty_cd = B.sty_cd
AND A.col_cd = B.col_cd
AND A.size_cd = B.size_cd
WHERE A.in_dt in ( '{{sel_days.value?.join('\' , \'')}}' )
AND substring(A.sty_cd, 1, 2) = brand_code
order by 1 desc,8 desc