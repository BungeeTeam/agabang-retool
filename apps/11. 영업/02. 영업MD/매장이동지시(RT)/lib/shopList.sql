select 
  distinct shop_cd, shop_nm 
from agabang_dw.daily_shop_sales_by_dimension
where biz_cd = '{{ bizSelect.value }}' 
and year(sale_dt) = year(today()) 
and user_cd != '30' 
and onoff_flag = '오프라인'
and team_cd not in ('60', '90', '98', '99')
order by shop_nm