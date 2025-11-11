SELECT 
  YEAR(sale_dt) as time_unit,
  shop_cd, shop_nm,
  br_cd, br_nm,
  biz_cd, sub_br_cd, sub_br_nm,
  onoff_flag,
  SUM(sales_price) / 1000 as rev
FROM agabang_dw.daily_shop_sales_by_dimension
WHERE date_format(sale_dt, '%m-%d') >= date_format(DATE '{{ dateRange.value.start || moment().startOf("year").format("YYYY-MM-DD") }}', '%m-%d') AND date_format(sale_dt, '%m-%d') <= date_format(DATE '{{ dateRange.value.end || moment().subtract(1, "days").format("YYYY-MM-DD") }}', '%m-%d') AND is_flex = true
GROUP BY
  YEAR(sale_dt),
  shop_cd, shop_nm, 
  br_cd, br_nm,
  biz_cd, sub_br_cd, sub_br_nm,
  onoff_flag