select 
  distinct shop_cd 
from agabang_dw.daily_shop_sales_by_dimension
where toYear(sale_dt) = toYear(today()) and toMonth(sale_dt) = toMonth(today()) - 1 and br_cd = '{{ brcd.value }}' and onoff_flag = '오프라인' and sales_type = '정상'