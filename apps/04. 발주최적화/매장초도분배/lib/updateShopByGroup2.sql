UPDATE dim_shop
SET is_checked = True
WHERE shop_cd IN ('{{ getSelectedGroupShop2.data.shop_cd.join("', '") }}')