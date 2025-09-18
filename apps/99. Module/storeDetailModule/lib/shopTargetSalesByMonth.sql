SELECT
    biz_cd,
    br_cd,
    toYear(plan_dt) as year_unit,
    formatDateTime(toDate(plan_dt), '%b') as month_unit,
    sum(target_sales) as target_sales
FROM agabang_dw.daily_target_sales_by_shop
WHERE shop_cd = '{{ selectedRow.value.shop_cd }}' 
and plan_dt <= '{{ endDate.value }}'
GROUP BY biz_cd,br_cd,year_unit,month_unit
ORDER BY biz_cd, br_cd,year_unit,month_unit;