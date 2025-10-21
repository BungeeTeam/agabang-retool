select 
  distinct(shop_nm) as shop_nm
from agabang_dw.day_shop_sty_sales
where br_cd='07'
order by 1