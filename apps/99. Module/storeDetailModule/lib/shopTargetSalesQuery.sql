SELECT
  plan_dt,
  yr_month,
  yr_quarter, 
  yr,
  SUM(target_sales) as "목표매출"
FROM (
  SELECT
    shop_cd,  
    target_sales,
    plan_dt,
    formatDateTime(plan_dt, '%Y-%m') as yr_month,
    toYear(plan_dt) as yr,
    concat(toString(toYear(plan_dt)), '-Q', toString(toQuarter(plan_dt))) AS yr_quarter
  FROM agabang_dw.daily_target_sales_by_shop
  WHERE shop_cd = '{{ selectedRow.value.shop_cd }}'
  AND date_format(plan_dt, '%Y-%m') <= date_format(DATE '{{  endDate.value }}', '%Y-%m')
) 
GROUP BY plan_dt, yr_month, yr_quarter, yr
ORDER BY yr_month
;