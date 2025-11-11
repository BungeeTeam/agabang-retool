with tbl as (
  select 
    distinct 
    large_cat as "대분류", 
    middle_cat as "중분류",
    small_cat as "소분류", 
    argMax(in_qty, adjusted_ratio) as "입고수량", 
    argMax(in_amt, adjusted_ratio) as "입고금액", 
    argMax(sale_qty, adjusted_ratio) as "판매수량", 
    argMax(sale_amt, adjusted_ratio) as "판매금액", 
    argMax(discount_ratio, adjusted_ratio) as "할인율", 
    argMax(tag_price, adjusted_ratio) as "판매TAG가", 
    argMax(cost_price, adjusted_ratio) as "입고원가", 
    argMax(mark_up, adjusted_ratio) as "입고배수", 
    argMax(sales_ratio_by_qty, adjusted_ratio) as "판매율(수량)", 
    argMax(sales_ratio_by_amt, adjusted_ratio) as "판매율(금액)",
    sty_cd as "스타일수", 
    col_cd as "컬러수",  
    argMax(out_qty, adjusted_ratio) as "출고수량",
    max(adjusted_ratio) as "목표판매율",
    argMax(adjusted_ord_qty, adjusted_ratio) as "최적발주수량",
    argMax(adjusted_ord_amt, adjusted_ratio) as "최적발주금액"
  from agabang_dw.seasonal_order_optimization
  where br_cd = '79' and adjusted_ratio <= {{ targetRatioInput3.value }} and year_cd = '{{ seasonSelect3.value.slice(0, 1) }}' and season_cd = '{{ seasonSelect3.value.slice(1, 2) }}'
  group by large_cat, middle_cat, small_cat, sty_cd, col_cd
  order by large_cat, middle_cat, small_cat
)
select
  row_number() OVER (order by "대분류", "중분류", "소분류") as rn, 
  *
from tbl
order by rn
;