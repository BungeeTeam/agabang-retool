UPDATE dim_shop
SET is_checked = {{ shopTbl.changesetArray[0].is_checked }}
WHERE shop_cd = '{{ shopTbl.changesetArray[0].shop_cd }}'