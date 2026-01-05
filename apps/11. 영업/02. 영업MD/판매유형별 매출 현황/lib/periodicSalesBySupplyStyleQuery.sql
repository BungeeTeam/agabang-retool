SELECT 
  YEAR(sale_dt) as year_unit,
  toQuarter(sale_dt) as quarter_unit,
  MONTH(sale_dt) as month_unit,
  CASE 
    WHEN sale_dt BETWEEN toDate('{{dateRange.value.start}}') AND toDate('{{dateRange.value.end}}') THEN 1
    ELSE 0
  END as is_current_period,
  br_cd,
  br_nm,
  biz_cd,
  sale_gb,
  coalesce(sub_br_cd,br_cd) as sub_br_cd,
  coalesce(sub_br_nm,br_nm) as sub_br_nm,
  season_nm,
  season_cd,
  season_seq,
  year_cd,
  year_nm,
  it,
  it_nm,
  it_gb,
  it_gb_nm,
  -- item,
  -- item_nm,
  onoff_flag,
  -- is_flex,
  first_lv_class,
  sales_type,
  -- second_lv_class,
  sum(sales_price) as rev,
  sum(sales_qty*tag_price) as tag,
  sum(cost_price) as cost
FROM agabang_dw.daily_shop_sales_by_dimension
WHERE (
  sale_dt BETWEEN toDate('{{dateRange.value.start}}') AND toDate('{{dateRange.value.end}}') OR
  sale_dt BETWEEN toDate(addYears('{{dateRange.value.start}}', -1)) AND toDate(addYears('{{dateRange.value.end}}', -1))
) --AND team_cd != '05'
AND sales_type = '용품'
GROUP BY
  year_unit,
  quarter_unit,
  month_unit,
  is_current_period,
  br_cd,
  br_nm,
  biz_cd,
  sale_gb,
  first_lv_class,
  -- second_lv_class,
  sub_br_cd,
  sub_br_nm,
  it,
  it_nm,
  it_gb,
  it_gb_nm,
  -- item,
  -- item_nm,
  onoff_flag,
  -- is_flex,
  season_nm,
  season_cd,
  season_seq,
  year_cd,
  year_nm,
  sales_type