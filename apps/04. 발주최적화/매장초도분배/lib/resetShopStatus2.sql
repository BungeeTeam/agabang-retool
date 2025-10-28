UPDATE dim_shop
SET is_checked = False
WHERE shop_cd IN ('{{ shopListQuery2.data.shop_cd.join("', '")}}')