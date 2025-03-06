SELECT 
  YEAR(sale_dt) as time_unit,
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
  SUM(sales_price) / 1000000 as rev
FROM agabang_dw.daily_shop_sales_by_dimension
WHERE date_format(sale_dt, '%m-%d') <= date_format(DATE '{{ yearlyDate.value }}', '%m-%d') AND MONTH(sale_dt) = {{ monthSelect.value + 1 }}
GROUP BY
  YEAR(sale_dt),
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