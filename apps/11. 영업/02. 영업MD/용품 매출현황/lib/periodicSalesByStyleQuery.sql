WITH 
  toDate('{{varDateRange.value?.start}}') as start_date,
  toDate('{{varDateRange.value?.end}}') as end_date

SELECT 
  toQuarter(sale_dt) as quarter_unit,
  MONTH(sale_dt) as month_unit,
  br_cd,
  br_nm,
  biz_cd,
  -- shop_cd,
  -- shop_nm,
  sub_br_cd,
  sub_br_nm,
  CASE WHEN season_cd in ('2','4','6','8') THEN CONCAT('시즌코드 ', season_cd) ELSE season_nm END as season_nm,
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
  sales_type,
  
  -- 현재년도 데이터
  sumIf(sales_qty, sale_dt BETWEEN start_date AND end_date) as curr_qty,
  sumIf(sales_price, sale_dt BETWEEN start_date AND end_date) as curr_amt,
  sumIf(sales_qty * tag_price, sale_dt BETWEEN start_date AND end_date) as curr_tag,
  sumIf(cost_price, sale_dt BETWEEN start_date AND end_date) as curr_cost,
  
  -- 전년도 데이터
  sumIf(sales_qty, sale_dt BETWEEN addYears(start_date, -1) AND addYears(end_date, -1)) as prev_qty,
  sumIf(sales_price, sale_dt BETWEEN addYears(start_date, -1) AND addYears(end_date, -1)) as prev_amt,
  sumIf(sales_qty*tag_price, sale_dt BETWEEN addYears(start_date, -1) AND addYears(end_date, -1)) as prev_tag,
  sumIf(cost_price, sale_dt BETWEEN addYears(start_date, -1) AND addYears(end_date, -1)) as prev_cost
  
FROM agabang_dw.daily_shop_sales_by_dimension
WHERE (
  sale_dt BETWEEN start_date AND end_date OR
  sale_dt BETWEEN addYears(start_date, -1) AND addYears(end_date, -1)
)
GROUP BY
  quarter_unit,
  month_unit,
  br_cd,
  br_nm,
  biz_cd,
  -- shop_cd,
  -- shop_nm,
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
  year_nm,
  sales_type;