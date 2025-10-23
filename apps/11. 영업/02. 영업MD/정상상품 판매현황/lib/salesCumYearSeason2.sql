WITH
    toDate('{{dateRange.value?.start }}') as start_date,
    toDate('{{dateRange.value?.end }}') as end_date,
    addYears(start_date, -1) as prev_start_date,
    addYears(end_date, -1) as prev_end_date,
    addYears(start_date, -2) as sale_start_date,
    ({{ bizSelect.value.map(i => `'${i}'`).join(',') }}) as biz_code,
    ({{ brandMultiSelect.value.map(i => `'${i}'`).join(',') }}) as brand_code,
    '{{ varShopSalesCatogory.value?.category_name }}' as selected_category_name,
    '{{ varShopSalesCatogory.value?.season_nm }}' as selected_season_nm,
    '{{ varShopSalesCatogory.value?.season_cd }}' as selected_season_cd,
    ({{tabs1.value==='합계' ? `'오프라인', '온라인'`:`'${tabs1.value}'`}}) as selected_onoff_flag

SELECT
distinct 'CURR' as period_type ,year_cd, season_cd, concat(year_cd, season_cd) as year_season_cd
FROM agabang_dw.daily_shop_sales_by_dimension
where sales_type = '정상'
and sale_dt between start_date and end_date
and biz_cd in biz_code
and br_cd in brand_code
AND season_cd in ('0','1','3','5','7')
ORDER BY year_cd, season_cd
-- and season_cd = selected_season_cd

UNION ALL
SELECT
distinct 'PREV' as period_type, year_cd, season_cd, concat(year_cd, season_cd) as year_season_cd
FROM agabang_dw.daily_shop_sales_by_dimension
where sales_type = '정상'
and sale_dt between prev_start_date and prev_end_date
and biz_cd in biz_code
and br_cd in brand_code
AND season_cd in ('0','1','3','5','7')
ORDER BY year_cd, season_cd
-- and season_cd = selected_season_cd