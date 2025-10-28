select 
  distinct shop_cd 
from agabang_dw.daily_shop_sales_by_dimension
where toYear(sale_dt) = toYear(today()) 
  and toMonth(sale_dt) = toMonth(today()) - 1 
  and br_cd = '{{ brcd2.value }}' 
  and onoff_flag = '오프라인' 
  and sales_type = '정상' 
  and season_cd != '0'
  and it = '{{ largeCatSelect2.value }}'
  and shop_cd not in (select distinct shop_cd from agabang_dw.dim_shop where user_cd = '31' and team_cd = '01')
  and shop_cd not in ('126146')