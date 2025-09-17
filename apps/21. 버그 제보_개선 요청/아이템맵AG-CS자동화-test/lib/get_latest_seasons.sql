WITH period_sales AS (
    SELECT
        season_cd,
        season_nm,
        concat(year_cd, season_cd) as year_season_cd,
        CASE
            WHEN sale_dt >= today() - INTERVAL 29 DAY THEN 'recent_30days'
            WHEN sale_dt >= today() - INTERVAL 59 DAY AND sale_dt < today() - INTERVAL 29 DAY THEN 'previous_30days'
        END as period_type,
        SUM(sales_qty) as period_sales_qty
    FROM agabang_dw.daily_shop_sales_by_dimension
    WHERE year_nm = toString(toYear(today()))
      AND sale_dt >= today() - INTERVAL 59 DAY  -- 최근 60일 데이터
      AND season_cd != '0'
      AND br_cd = '{{ variable0 }}'
    GROUP BY year_cd, season_cd, season_nm, period_type
),
season_comparison AS (
    SELECT
        season_cd,
        season_nm,
        year_season_cd,
        SUM(CASE WHEN period_type = 'recent_30days' THEN period_sales_qty ELSE 0 END) as recent_30days_qty,
        SUM(CASE WHEN period_type = 'previous_30days' THEN period_sales_qty ELSE 0 END) as previous_30days_qty
    FROM period_sales
    WHERE period_type IS NOT NULL
    GROUP BY season_cd, season_nm, year_season_cd
)
SELECT
    season_cd,
    season_nm,
    year_season_cd,
    recent_30days_qty,
    previous_30days_qty,
    (recent_30days_qty - previous_30days_qty) as growth_qty,
    CASE
        WHEN previous_30days_qty > 0 THEN
            ROUND(((recent_30days_qty - previous_30days_qty) / previous_30days_qty) * 100, 2)
        ELSE NULL
    END as growth_rate_percent
FROM season_comparison
WHERE previous_30days_qty > 0  -- 이전 30일 판매가 있었던 시즌만 비교
ORDER BY growth_rate_percent DESC
LIMIT {{ variable1 }};


-- SELECT
--     season_cd,
--     season_nm,
--     concat(year_cd,season_cd) as year_season_cd,
--     SUM(sales_qty) as total_sales_qty
-- FROM agabang_dw.daily_shop_sales_by_dimension
-- WHERE year_nm = toString(toYear(today()))
--   AND sale_dt >= today() - INTERVAL 1 MONTH
--   AND season_cd != '0'
--   AND br_cd = '{{ variable0 }}'
-- GROUP BY year_cd, season_cd, season_nm
-- ORDER BY 4 desc
-- LIMIT {{ variable1 }};