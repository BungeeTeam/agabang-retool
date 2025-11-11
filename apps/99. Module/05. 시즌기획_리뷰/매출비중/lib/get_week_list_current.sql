SELECT
    row_number() over () AS index,
    B.sty_cd AS sty_cd,
--                 min(A.sale_dt) as sale_dt,
    max(B.sty_nm) AS sty_nm,
    sum(A.sale_qty) AS sale_qty,
    sum(A.sale_qty * B.tag_prce) AS sale_tag_amt,
    sum(A.sale_amt) AS sale_amt

FROM agabang.plstycd AS B
LEFT OUTER JOIN agabang_dw.daily_sales_by_style AS A
ON A.comp_cd = B.comp_cd AND A.sty_cd = B.sty_cd
WHERE 1=1
AND B.br_cd = '{{ brand_code.value }}'
AND A.sale_dt BETWEEN '{{ dateRange1.value.start }}' AND '{{ dateRange1.value.end }}'
GROUP BY B.sty_cd
order by index