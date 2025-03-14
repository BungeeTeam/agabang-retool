WITH tbl as (
SELECT * FROM (
  SELECT
    YEAR(sale_dt) as time_unit, 
    date_format(sale_dt, '%y-%m') as ym,
    shop_cd, shop_nm, 
    biz_cd, biz_nm, 
    br_cd, br_nm, 
    tp_cd, tp_nm,
    team_cd, team_nm,
    user_cd, user_nm,
    area_cd, area_nm, onoff_flag,
    sum(sales_price) as rev
  FROM agabang_dw.daily_shop_sales_by_dimension
  WHERE date_format(sale_dt, '%m-%d') >= date_format(DATE '{{ dateRange.value.start || moment().format("YYYY-MM-DD") }}', '%m-%d') AND date_format(sale_dt, '%m-%d') <= date_format(DATE '{{ dateRange.value.end || moment().format("YYYY-MM-DD") }}', '%m-%d')
  GROUP BY 
    YEAR(sale_dt), date_format(sale_dt, '%y-%m'),
    shop_cd, shop_nm, 
    biz_cd, biz_nm,
    br_cd, br_nm,
    tp_cd, tp_nm,
    team_cd, team_nm,
    user_cd, user_nm,
    area_cd, area_nm, onoff_flag
) as A
FULL OUTER JOIN (
  SELECT br_cd, shop_cd, year_month, target_sales
  FROM agabang_dw.yearly_target_sales_by_shop
) as B
ON A.br_cd = B.br_cd AND A.shop_cd = B.shop_cd AND A.ym = date_format(B.year_month, '%y-%m')
)
SELECT 
  time_unit, shop_cd, shop_nm, biz_cd, biz_nm,
  br_cd, br_nm,
  tp_cd, tp_nm, team_cd, team_nm,
  user_cd, user_nm, area_cd, area_nm, onoff_flag,
  SUM(rev) / 1000000 as rev, 
  COALESCE(SUM(target_sales), 0) / 1000000 as target_sales
FROM tbl
GROUP BY time_unit, shop_cd, shop_nm, biz_cd, biz_nm,
  br_cd, br_nm,
  tp_cd, tp_nm, team_cd, team_nm,
  user_cd, user_nm, area_cd, area_nm, onoff_flag