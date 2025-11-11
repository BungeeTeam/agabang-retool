SELECT biz_cd, biz_nm
FROM agabang_dw.daily_shop_sales_by_dimension
WHERE sale_dt = yesterday()
GROUP BY biz_cd, biz_nm
ORDER BY SUM(sales_price) DESC