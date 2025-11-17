select 
  t2.it_nm as large_cat,
  t2.it_gb_nm as middle_cat,
  t2.item_nm as small_cat
from (
  select 
    distinct 
      large_cat, 
      middle_cat, 
      small_cat
  from agabang_dw.seasonal_order_distribution 
  where season_cd = '{{ seasonSelect2.value.slice(1, 2) }}' 
  and year_cd = '{{ getPreviousChar(seasonSelect2.value.slice(0, 1)) }}'
  and br_cd = '07'
) t1
left join (
  select 
    distinct large_cat, middle_cat, small_cat, it_nm, it_gb_nm, item_nm 
  from agabang_dw.dim_style
) t2
on t1.large_cat = t2.large_cat and t1.middle_cat = t2.middle_cat and t1.small_cat = t2.small_cat