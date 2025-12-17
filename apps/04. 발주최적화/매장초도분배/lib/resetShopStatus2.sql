UPDATE dim_shop_v2
SET is_checked = False
WHERE shop_cd IN ('{{ shopListQuery2.data.shop_cd.join("', '")}}')
AND biz_cd = '{{ bizcd2.value }}'