SELECT
distinct shop_cd as shop_cd, 
shop_nm as shop_nm
FROM agabang_dw.daily_shop_sales_by_dimension
WHERE br_cd = '79'
and toYear(sale_dt) = toYear(toDate('{{dateRange.value.start}}'))