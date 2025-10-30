SELECT
    YEAR(plan_dt) as year_unit,
    toQuarter(plan_dt) as quarter_unit,
    MONTH(plan_dt) as month_unit,
    biz_cd,
    onoff_flag,
    sum(target_sales) as target_sales
FROM agabang_dw.daily_target_sales_by_shop as A
WHERE plan_dt between '{{dateRange.value.start}}' and '{{dateRange.value.end}}'
GROUP BY
  year_unit,
  quarter_unit,
  month_unit,
  biz_cd,
  onoff_flag