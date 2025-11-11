SELECT
distinct tp_cd as channel_cd,tp_nm as channel_gb
FROM agabang_dw.daily_shop_sales_by_dimension
WHERE br_cd = '79'
and toYear(sale_dt) = toYear(toDate('{{dateRange.value.start}}'))