select 
  distinct tp_cd, tp_nm 
from agabang_dw.dim_shop
where biz_cd = '{{ bizSelect.value }}' and tp_nm != ''
order by tp_nm