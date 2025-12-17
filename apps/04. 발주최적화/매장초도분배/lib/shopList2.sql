SELECT shop_cd, shop_nm, default_qty, is_checked, idx
FROM dim_shop_v2 WHERE biz_cd = '{{ bizcd2.value }}'