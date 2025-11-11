select
    A.sty_cd as sty_cd,
    A.sty_nm as sty_nm,
    A.col_nm as col_nm,
    A.size_nm as size_nm,
    A.tot_in_qty,
    A.tot_sale_qty,
    ROUND(A.tot_sale_qty / NULLIF(A.tot_in_qty, 0), 2) as sale_per
from agabang_dw.prod_sales_stock_by_size as A
where A.sty_cd = '{{var_sel_sty_info.value.sty_cd}}'
and A.col_cd = '{{var_sel_sty_info.value.col_cd}}'