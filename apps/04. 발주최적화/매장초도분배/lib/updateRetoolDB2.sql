UPDATE dim_shop
SET is_checked = {{ shopTbl2.changesetArray[0].is_checked }}
WHERE shop_cd = '{{ shopTbl2.changesetArray[0].shop_cd }}'