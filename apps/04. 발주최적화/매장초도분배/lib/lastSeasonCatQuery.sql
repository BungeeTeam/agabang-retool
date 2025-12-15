select 
  t2.it_nm as large_cat,
  coalesce(t3.it_gb_nm, t1.middle_cat) as middle_cat,
  coalesce(t4.item_nm, t1.small_cat) as small_cat
from (
  select 
    distinct 
      large_cat, 
      middle_cat, 
      small_cat
  from agabang_dw.seasonal_order_distribution 
  where season_cd = '{{ seasonSelect.value.slice(1, 2) }}' 
  and year_cd = '{{ getPreviousChar(seasonSelect.value.slice(0, 1)) }}'
  and br_cd = '{{ brcd.value }}'
) t1
left join (
  select 
    distinct large_cat, it_nm
  from agabang_dw.dim_style
) t2
on t1.large_cat = t2.large_cat
left join (
  select 
    distinct middle_cat, it_gb_nm
  from agabang_dw.dim_style
) t3
on t1.middle_cat = t3.middle_cat
left join (
  select 
    distinct small_cat, item_nm
  from agabang_dw.dim_style
) t4
on t1.small_cat = t4.small_cat