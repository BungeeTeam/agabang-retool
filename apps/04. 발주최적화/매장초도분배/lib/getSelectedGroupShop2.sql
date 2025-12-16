select
  t1.shop_cd as shop_cd,
  t2.shop_nm as shop_nm,
  t2.tp_nm,
  t2.team_nm,
  t2.user_nm
from (
  select distinct shop_cd from agabang.cfshgrpd
  where grp_id = '{{ groupSelect2.value }}' and use_yn = 'Y' and biz_div = 'A4' -- {{ bizcd2.value }}
) as t1
left join (
  select distinct shop_cd, shop_nm, tp_nm, team_nm, user_nm from agabang_dw.dim_shop
) as t2
on t1.shop_cd = t2.shop_cd
;