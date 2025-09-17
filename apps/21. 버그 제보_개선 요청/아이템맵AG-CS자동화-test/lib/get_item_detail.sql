select
    A.sty_cd as sty_cd,
    A.sty_nm as sty_nm,
    A.col_nm as col_nm,
    A.plan_qty,
    A.tot_sale_qty,
    A.tot_in_qty,
    ROUND(A.tot_sale_qty / NULLIF(A.tot_in_qty, 0), 2) as sale_per,
    A.int_sale_qty,
    B.fabric,
    A.col_nm as col_nm,
    B.designer_nm,
    B.prod_comp,
    B.prod_country,
    A.fout_date,
    A.fin_date,
    A.plan_date,
    A.tag_prce,
    C.final_sale_prce as real_prce,
    A.cost_prce as cost_prce,
    A.tag_prce / nullif(A.cost_prce*1.1, 0) as markup,
    A.tot_in_tag_amt,
    A.tot_sale_amt,
    ROUND(A.tot_sale_amt / NULLIF(A.tot_in_tag_amt, 0), 2) as sale_amt_per,
    ROUND(A.tot_sale_amt / NULLIF(A.tot_cost_amt, 0), 2) as sale_return_per
from agabang_dw.prod_sales_stock_by_color as A
join (
    select
        sty_cd,
        max(sty_nm) as sty_nm,
        max(cat_nm) as cat_nm,
        max(fabric) as fabric,
        max(designer_nm) as designer_nm,
        max(prod_comp) as prod_comp,
        max(prod_country) as prod_country
    from agabang_dw.retooldb_item_md_info
    group by 1
) as B
on A.sty_cd = B.sty_cd
join (
  select
    sty_cd,
    col_cd,
    max(final_sale_prce) as final_sale_prce
  from agabang_dw.prod_final_price
  group by 1, 2
) as C
on A.sty_cd = C.sty_cd
  and A.col_cd = C.col_cd
where A.sty_cd = '{{var_sel_sty_info.value.sty_cd}}'
and A.col_cd = '{{var_sel_sty_info.value.col_cd}}'
limit 0,1