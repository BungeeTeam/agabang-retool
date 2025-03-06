SELECT
  shop_cd, 
  shop_nm,
  open_dt,
  array_agg(distinct biz_nm) as biz_nm,
  array_agg(distinct br_nm) as br_nm,
  max(gb_nm) as gb_nm,
  max(tp_nm) as tp_nm,
  max(team_nm) as team_nm,
  max(user_nm) as user_nm,
  max(area_nm) as area_nm
FROM agabang_dw.dim_shop
WHERE shop_cd = '{{ selectedShopInfo.value.shop_cd }}'
GROUP BY shop_cd, shop_nm, open_dt