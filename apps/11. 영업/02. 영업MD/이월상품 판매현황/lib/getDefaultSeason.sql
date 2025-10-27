WITH period_sales AS (
    SELECT
        season_cd,
        season_nm,
        concat(year_cd, season_cd) as year_season_cd,
        concat(year_nm_short, season_nm_eng) as year_season_eng,
        CASE
            WHEN sale_dt >= today() - INTERVAL 29 DAY THEN 'recent_30days'
            WHEN sale_dt >= today() - INTERVAL 59 DAY AND sale_dt < today() - INTERVAL 29 DAY THEN 'previous_30days'
        END as period_type,
        SUM(sales_qty) as period_sales_qty
    FROM
        (
         SELECT
             *,
             substring(year_nm,3,2) as year_nm_short,
             CASE WHEN season_cd in ('1','2') THEN 'SP'
                 WHEN season_cd in ('3','4') THEN 'SM'
                 WHEN season_cd in ('5','6') THEN 'FA'
                WHEN season_cd in ('7','8') THEN 'WT'
                WHEN season_cd = '0' THEN 'NO' END as season_nm_eng
         FROM agabang_dw.daily_shop_sales_by_dimension
        )
    WHERE year_nm = toString(toYear(today()))
      AND sale_dt >= today() - INTERVAL 59 DAY
      AND season_cd != '0'
      AND biz_cd = '{{bizMultiSelect2.value }}'
    GROUP BY year_cd, season_cd, season_nm, period_type, year_season_eng
),
season_comparison AS (
    SELECT
        season_cd,
        season_nm,
        year_season_cd,
        year_season_eng,
        SUM(CASE WHEN period_type = 'recent_30days' THEN period_sales_qty ELSE 0 END) as recent_30days_qty,
        SUM(CASE WHEN period_type = 'previous_30days' THEN period_sales_qty ELSE 0 END) as previous_30days_qty
    FROM period_sales
    WHERE period_type IS NOT NULL
    GROUP BY season_cd, season_nm, year_season_cd,year_season_eng
)
SELECT
    season_cd,
    season_nm,
    year_season_cd,
    year_season_eng,
    recent_30days_qty,
    previous_30days_qty,
    (recent_30days_qty - previous_30days_qty) as growth_qty,
    CASE
        WHEN previous_30days_qty > 0 THEN
            ROUND(((recent_30days_qty - previous_30days_qty) / previous_30days_qty) * 100, 2)
        ELSE NULL
    END as growth_rate_percent
FROM season_comparison
WHERE recent_30days_qty > 0
ORDER BY recent_30days_qty DESC
LIMIT 1;