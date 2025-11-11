with tbl as (
  select 
    distinct 
    large_cat as "대분류", 
    middle_cat as "중분류",
    small_cat as "소분류", 
    in_qty as "입고수량", 
    in_amt as "입고금액", 
    sale_qty as "판매수량", 
    sale_amt as "판매금액", 
    tag_price as "판매TAG가", 
    cost_price as "입고원가", 
    mark_up as "입고배수", 
    sales_ratio_by_qty as "판매율(수량)", 
    sales_ratio_by_amt as "판매율(금액)", 
    sty_cd as "스타일수", 
    col_cd as "컬러수",  
    out_qty as "출고수량",
    *
  from agabang_dw.seasonal_order_optimization
  where br_cd = '07' and year_cd = '{{ seasonSelect2.value.slice(0, 1) }}' and season_cd = '{{ seasonSelect2.value.slice(1, 2) }}'
)
select 
  DENSE_RANK() OVER (ORDER BY "대분류", "중분류", "소분류") as rn, 
  * 
from tbl
;