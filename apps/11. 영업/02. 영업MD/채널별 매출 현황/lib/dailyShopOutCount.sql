WITH first_shipment_date AS (
  SELECT toDate(MIN(wrk_dt)) AS min_date
  FROM agabang.dsoutrtn
  WHERE toDate(wrk_dt) between '2024-04-15' and '2025-06-01'
  AND substring(sty_cd, 1, 4) = '79S3'
),
daily_store_counts AS (
  SELECT
    first_out_date AS out_dt,
    COUNT(*) AS store_count
  FROM (
    SELECT
      shop_cd,
      MIN(toDate(wrk_dt)) AS first_out_date
    FROM agabang.dsoutrtn
    WHERE toDate(wrk_dt) BETWEEN '2024-04-15' AND '2025-06-01'
      AND substring(sty_cd, 1, 4) = '79S3'
    GROUP BY shop_cd
  ) AS first_out_per_shop
  GROUP BY first_out_date
),
store_counts_with_day_offset AS (
  SELECT
    A.out_dt,
    A.store_count,
    dateDiff('day',B.min_date,A.out_dt) AS day_offset
  FROM daily_store_counts as A
  CROSS JOIN first_shipment_date as B
)
  SELECT
    day_offset,
    SUM(store_count) OVER (
      ORDER BY day_offset
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cum_store_count
  FROM store_counts_with_day_offset
