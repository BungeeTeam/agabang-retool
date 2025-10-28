UPDATE dim_shop
SET is_checked = True
WHERE shop_cd IN ('{{ effectiveShops.data.shop_cd.join("', '") }}')