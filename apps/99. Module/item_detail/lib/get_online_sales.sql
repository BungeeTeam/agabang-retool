WITH
  brand_code AS (SELECT '{{brand_code.value}}' AS val),
  expected_sale_gb AS (
    SELECT '오프라인(매장)' AS sale_gb UNION ALL
    SELECT '온라인 - 자사몰' UNION ALL
    SELECT '온라인 - 외부몰' UNION ALL
    SELECT '온라인 - 매장'
  ),
  RAW_SALES AS (
    SELECT
        CASE 
            WHEN sale_gb = '온라인판매' AND shop_cd = '125290' THEN '온라인 - 자사몰'
            WHEN sale_gb = '온라인판매' AND shop_cd != '125290' 
                 AND shop_cd IN (
                   SELECT shop_cd 
                   FROM dim_shop 
                   WHERE onoff_flag = '오프라인'
                 ) THEN '온라인 - 매장'
            WHEN sale_gb = '온라인판매' AND shop_cd != '125290' THEN '온라인 - 외부몰'
            WHEN sale_gb = '매장판매' THEN '오프라인(매장)'
            ELSE sale_gb 
        END AS sale_gb,
        sale_dt,
        SUM(sales_qty) AS sales_qty
    FROM agabang_dw.daily_shop_sales_by_color
    WHERE br_cd = (SELECT val FROM brand_code)
      AND sty_cd = '{{sel_sty.value?.sty_cd}}'
      AND col_cd = '{{sel_sty.value?.col_cd}}'
    GROUP BY 1, 2
  ),
  SALE_GB_SALES AS (
    SELECT
        sale_gb,
        sale_dt,
        SUM(SUM(sales_qty)) OVER (PARTITION BY sale_gb ORDER BY sale_dt) AS cum_sale_qty
    FROM RAW_SALES
    GROUP BY 1, 2
  ),
  SALE_GB_TREND AS (
    SELECT
        sale_gb,
        arrayMap(
            (day, val) -> '{"day":"' || toString(day) || '", "val":' || toString(val) || ', "sale_gb":"' || replaceAll(sale_gb, '"', '\\"') || '"}',
            groupArray(sale_dt),
            groupArray(cum_sale_qty)
        ) AS sale_trend
    FROM SALE_GB_SALES
    GROUP BY 1
  ),
  FILLED_SALE_GB_TREND AS (
    SELECT
        e.sale_gb,
        COALESCE(s.sale_trend, []) AS sale_trend
    FROM expected_sale_gb e
    LEFT JOIN SALE_GB_TREND s ON e.sale_gb = s.sale_gb
  )
SELECT
  sale_gb,
  concat('[', arrayStringConcat(sale_trend, ','), ']') AS sale_trend
FROM FILLED_SALE_GB_TREND
ORDER BY 
  CASE sale_gb 
    WHEN '오프라인(매장)' THEN 1
    WHEN '온라인 - 자사몰' THEN 2
    WHEN '온라인 - 외부몰' THEN 3
    WHEN '온라인 - 매장' THEN 4
    ELSE 5
  END
