select
  distinct
    shop_cd, 
    shop_nm, 
    biz_nm,
    tp_nm,
    team_nm,
    user_nm,
    area_nm
from agabang_dw.dim_shop 
where br_cd = '{{ brcd.value }}' 
and close_dt > today()
and team_cd not in ('09', '60', '90', '99')
order by shop_nm