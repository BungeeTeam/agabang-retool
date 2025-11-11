select 
  distinct br_cd, br_nm
from agabang_dw.dim_shop
where biz_cd = '{{ bizSelect.value }}'
order by biz_cd, br_cd, br_nm