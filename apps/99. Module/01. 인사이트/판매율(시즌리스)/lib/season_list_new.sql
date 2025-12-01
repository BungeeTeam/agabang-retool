WITH
     (
    select
    CAST(year_nm as INT)
from agabang_dw.daily_shop_sales_by_dimension
where br_cd = '{{brand_code.value}}' and season_cd = '0' and year_nm not like '%이하%'
order by year_nm desc
limit 1
    ) as sale_year

SELECT
max(A.year_cd) as year_cd,
min(A.year_sesn_cd) as year_sesn_cd,
A.year_nm as year_nm

FROM agabang_dw.code_season as A
WHERE CAST(year_nm as INT) between sale_year -4 and sale_year
GROUP BY year_nm
ORDER BY year_nm desc

-- WITH 
-- toYear(toDate('{{date_select.value}}')) as year_1st,
-- toYear(toDate('{{date_select.value}}')) - 4 as year_last

-- SELECT
-- max(A.year_cd) as year_cd,
-- min(A.year_sesn_cd) as year_sesn_cd,
-- A.year_nm as year_nm
-- -- ,toYear(toDate('{{date_select.value}}')) as year_,
-- -- toYear(toDate('{{date_select.value}}')) - 4 as year__
-- FROM agabang_dw.code_season as A
-- WHERE year_nm between cast(toYear(toDate('{{date_select.value}}')) -4 AS String) and cast(toYear(toDate('{{date_select.value}}')) AS String)
-- GROUP BY year_nm
-- ORDER BY year_nm desc