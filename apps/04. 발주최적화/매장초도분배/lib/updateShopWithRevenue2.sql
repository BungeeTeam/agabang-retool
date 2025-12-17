UPDATE dim_shop
SET is_checked = True
WHERE shop_cd IN ('{{ effectiveShops2.data.shop_cd?.join("', '") }}')
AND biz_cd = '{{ bizcd2.value }}'