SELECT
    season_cd,
    season_nm,
    concat(year_cd,season_cd) as year_season_cd,
    SUM(sales_qty) as total_sales_qty
FROM agabang_dw.daily_shop_sales_by_dimension
WHERE year_nm = toString(toYear(today()))
  AND sale_dt >= today() - INTERVAL 1 MONTH
  AND season_cd != '0'
  AND br_cd = '{{ variable0 }}'
GROUP BY year_cd, season_cd, season_nm
ORDER BY 4 desc
LIMIT {{ variable1 }};