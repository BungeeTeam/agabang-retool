SELECT 
  concat(biz_cd,shop_cd) as idx,
  shop_cd, shop_nm,
  biz_cd, biz_nm
FROM agabang_dw.f_daily_sales_by_shop
WHERE md <= date_format(DATE '{{ moment().subtract(1,'days').format('YYYY-MM-DD') }}', '%m-%d') 
  AND md >= date_format(DATE '{{ moment().startOf('month').format('YYYY-MM-DD') }}', '%m-%d') 
  AND CONCAT(shop_cd, shop_nm) LIKE '%{{ search_text.value }}%'
GROUP BY 
shop_cd, shop_nm,
biz_cd, biz_nm
limit 100