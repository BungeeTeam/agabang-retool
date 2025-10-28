UPDATE dim_shop
SET is_checked = False
WHERE shop_cd IN ('{{ shopListQuery.data.shop_cd.join("', '")}}')