SELECT 
  YEAR(sale_dt) as year_unit,
  toQuarter(sale_dt) as quarter_unit,
  MONTH(sale_dt) as month_unit,
  br_cd,
  br_nm,
  biz_cd,
  sub_br_cd,
  sub_br_nm,
  CASE WHEN season_cd in ('2','4','6','8') THEN concat('시즌코드 ',season_cd) ELSE season_nm END as season_nm,
  season_cd,
  year_cd,
  year_nm,
  it,
  it_nm,
  it_gb,
  it_gb_nm,
  onoff_flag,
  sum(sales_price) as rev,
  sum(sales_qty*tag_price) as tag,
  sum(cost_price) as cost,
  sales_type
FROM agabang_dw.daily_shop_sales_by_dimension
WHERE (
  sale_dt BETWEEN toDate('{{dateRange.value.start}}') AND toDate('{{dateRange.value.end}}') OR
  sale_dt BETWEEN toDate(addYears('{{dateRange.value.start}}', -1)) AND toDate(addYears('{{dateRange.value.end}}', -1))
) --AND team_cd != '05'
AND it not in ('6','8') -- 용품 제외
--AND season_cd in ('1','3','5','7','0')
GROUP BY
  year_unit,
  quarter_unit,
  month_unit,
  br_cd,
  br_nm,
  biz_cd,
  -- sale_gb,
  -- first_lv_class,
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
  -- season_seq,
  year_cd,
  year_nm,
sales_type