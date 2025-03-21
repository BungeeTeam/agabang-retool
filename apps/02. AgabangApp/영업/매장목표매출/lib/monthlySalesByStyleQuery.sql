SELECT 
  YEAR(sale_dt) as time_unit,
  sales_type,
  br_cd,
  biz_cd,
  sub_br_cd,
  sub_br_nm,
  season_nm,
  season_cd,
  year_cd,
  year_nm,
  it,
  it_nm,
  it_gb,
  it_gb_nm,
  item,
  item_nm,
  onoff_flag,
  CASE
      WHEN it = '8' THEN '용품'
      WHEN it != '8' AND sale_dt <= season_end_dt THEN '정상'
      ELSE '이월'
    END AS sales_type,
  first_lv_class,
  second_lv_class,
  SUM(sales_price) / 1000000 as rev
FROM agabang_dw.daily_shop_sales_by_dimension
WHERE date_format(sale_dt, '%m-%d') <= date_format(DATE '{{ dateRange.value.end || moment().subtract(1, "days").format("YYYY-MM-DD") }}', '%m-%d') AND MONTH(sale_dt) = {{ monthSelect.value + 1 }}
GROUP BY
  YEAR(sale_dt),
  sales_type,
  first_lv_class,
  second_lv_class,
  br_cd,
  biz_cd,
  sub_br_cd,
  sub_br_nm,
  it,
  it_nm,
  it_gb,
  it_gb_nm,
  item,
  item_nm,
  onoff_flag,
  season_nm,
  season_cd,
  year_cd,
  year_nm