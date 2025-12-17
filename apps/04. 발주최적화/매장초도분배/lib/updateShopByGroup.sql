UPDATE dim_shop_v2
SET is_checked = True
WHERE shop_cd IN ('{{ getSelectedGroupShop.data.shop_cd.join("', '") }}')
AND biz_cd = '{{ bizcd.value }}'