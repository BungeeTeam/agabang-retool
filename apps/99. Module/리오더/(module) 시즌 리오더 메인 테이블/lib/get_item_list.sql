-- get_item_list (ClickHouse 호환 버전)
-- 서브쿼리 외부 스코프 참조 문제 해결

-- Align date constants with original query logic
WITH 
-- 날짜 상수
aligned_date_constants AS (
  SELECT 
    toDate(parseDateTimeBestEffort('{{inputReferenceDate.value}}')) AS ref_date,
    addDays(toDate(parseDateTimeBestEffort('{{inputReferenceDate.value}}')), -6) AS date_7d_ago,
    addDays(toDate(parseDateTimeBestEffort('{{inputReferenceDate.value}}')), -29) AS date_30d_ago,
    addDays(toDate(parseDateTimeBestEffort('{{inputReferenceDate.value}}')), -179) AS date_180d_ago,
    addDays(toDate(parseDateTimeBestEffort('{{inputReferenceDate.value}}')), -364) AS date_365d_ago,
    toStartOfWeek(multiIf(toDayOfWeek(today()) = 1, addDays(today(), -7), today()), 1) AS ref_week_start
),

-- 첫 출고일 데이터 (기존 get_item_list.sql과 동일한 로직)
first_outbound_dates AS (
  SELECT
    D.sty_cd,
    D.col_cd,
    D.size_cd,
    min(D.sale_dt) AS first_outbound_date
  FROM daily_data_by_size D
  WHERE D.out_qty > 0  -- 출고 수량이 있는 날짜만 고려
  GROUP BY D.sty_cd, D.col_cd, D.size_cd
),

-- 총 출고량 정보 (기존 get_item_list.sql과 동일한 로직)
outbound_qty_info AS (
  SELECT
    D.sty_cd,
    D.col_cd,
    D.size_cd,
    toFloat64(sum(D.out_qty)) AS tot_out_qty  -- 총 출고량
  FROM daily_data_by_size D
  GROUP BY D.sty_cd, D.col_cd, D.size_cd
),

-- 일별 집계 데이터
daily_stats AS (
  SELECT 
    D.sty_cd, D.col_cd, D.size_cd,
    min(multiIf(D.in_qty > 0, D.sale_dt, NULL)) AS first_inventory_date,
    max(multiIf(D.in_qty > 0, D.sale_dt, NULL)) AS last_inventory_date,
    
    -- 순수 7일 판매량 (브랜드 조건 없음)
    toFloat64(sum(multiIf(D.sale_dt >= DC.date_7d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0, D.sale_qty, 0))) AS pure_sales_7d,
    
    -- 7일 판매량 (브랜드 조건 포함) - 단순화
    toFloat64(sum(multiIf(D.sale_dt >= DC.date_7d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0 AND D.br_cd = '{{ var_brand_code.value }}', D.sale_qty, 0))) AS sales_7d,
    
    toFloat64(sum(multiIf(D.sale_dt >= DC.date_30d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0, D.sale_qty, 0))) AS sales_30d,
    toFloat64(sum(multiIf(D.sale_dt >= DC.date_180d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0, D.sale_qty, 0))) AS sales_180d,
    toFloat64(sum(multiIf(D.sale_dt >= DC.date_365d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0, D.sale_qty, 0))) AS sales_365d,
    
    -- 전체 기간 판매량 (365일 판매량으로 근사)
    toFloat64(sum(multiIf(D.sale_dt >= DC.date_365d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0, D.sale_qty, 0))) AS total_all_time_sale_qty,
    
    -- 실제 판매 기간별 첫 판매일/마지막 판매일
    min(multiIf(D.sale_dt >= DC.date_7d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0 AND D.br_cd = '{{ var_brand_code.value }}', D.sale_dt, NULL)) AS first_sale_date_7d,
    max(multiIf(D.sale_dt >= DC.date_7d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0 AND D.br_cd = '{{ var_brand_code.value }}', D.sale_dt, NULL)) AS last_sale_date_7d,
    min(multiIf(D.sale_dt >= DC.date_30d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0, D.sale_dt, NULL)) AS first_sale_date_30d,
    max(multiIf(D.sale_dt >= DC.date_30d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0, D.sale_dt, NULL)) AS last_sale_date_30d,
    min(multiIf(D.sale_dt >= DC.date_180d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0, D.sale_dt, NULL)) AS first_sale_date_180d,
    max(multiIf(D.sale_dt >= DC.date_180d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0, D.sale_dt, NULL)) AS last_sale_date_180d,
    min(multiIf(D.sale_dt >= DC.date_365d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0, D.sale_dt, NULL)) AS first_sale_date_365d,
    max(multiIf(D.sale_dt >= DC.date_365d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0, D.sale_dt, NULL)) AS last_sale_date_365d,
    
    -- 판매 일수 (원본과 동일한 로직: 실제 판매 데이터 범위 기준) - 단순화
    toFloat64(greatest(
      1,
      least(
        7,
        dateDiff('day', 
                 multiIf(
                   min(multiIf(D.sale_dt >= DC.date_7d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0 AND D.br_cd = '{{ var_brand_code.value }}', D.sale_dt, NULL)) IS NOT NULL,
                   min(multiIf(D.sale_dt >= DC.date_7d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0 AND D.br_cd = '{{ var_brand_code.value }}', D.sale_dt, NULL)),
                   DC.date_7d_ago
                 ),
                 multiIf(
                   max(multiIf(D.sale_dt >= DC.date_7d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0 AND D.br_cd = '{{ var_brand_code.value }}', D.sale_dt, NULL)) IS NOT NULL,
                   max(multiIf(D.sale_dt >= DC.date_7d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0 AND D.br_cd = '{{ var_brand_code.value }}', D.sale_dt, NULL)),
                   DC.ref_date
                 )) + 1
      )
    )) AS sales_days_7d,
    
    toFloat64(greatest(
      1,
      least(
        30,
        dateDiff('day', 
                 multiIf(
                   min(multiIf(D.sale_dt >= DC.date_30d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0, D.sale_dt, NULL)) IS NOT NULL,
                   min(multiIf(D.sale_dt >= DC.date_30d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0, D.sale_dt, NULL)),
                   DC.date_30d_ago
                 ),
                 multiIf(
                   max(multiIf(D.sale_dt >= DC.date_30d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0, D.sale_dt, NULL)) IS NOT NULL,
                   max(multiIf(D.sale_dt >= DC.date_30d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0, D.sale_dt, NULL)),
                   DC.ref_date
                 )) + 1
      )
    )) AS sales_days_30d,
    
    toFloat64(COUNT(DISTINCT multiIf(D.sale_dt >= DC.date_180d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0, D.sale_dt, NULL))) AS sales_days_180d,
    toFloat64(COUNT(DISTINCT multiIf(D.sale_dt >= DC.date_365d_ago AND D.sale_dt <= DC.ref_date AND D.sale_qty > 0, D.sale_dt, NULL))) AS sales_days_365d,
    
    DC.ref_date
  FROM daily_data_by_size D
  CROSS JOIN aligned_date_constants DC
  WHERE D.sale_dt >= DC.date_7d_ago AND D.sale_dt <= DC.ref_date
  GROUP BY D.sty_cd, D.col_cd, D.size_cd, DC.ref_date, DC.date_7d_ago, DC.date_30d_ago, DC.date_180d_ago, DC.date_365d_ago
),

-- 컬러별 집계
color_stats AS (
  SELECT
    P.sty_cd, P.col_cd,
    toFloat64(sum(P.tot_in_qty)) AS color_tot_in_qty,
    toFloat64(sum(P.tot_sale_qty)) AS color_tot_sale_qty,
    toFloat64(sum(P.tot_in_qty - P.tot_sale_qty)) AS color_current_stock,
    toFloat64(sum(P.wh_stck_qty)) AS color_wh_stck_qty,
    toFloat64(sum(P.sh_stck_qty)) AS color_sh_stck_qty
  FROM prod_sales_stock_by_size P
  GROUP BY P.sty_cd, P.col_cd
),

-- 컬러별 출고량
color_outbound AS (
  SELECT
    sty_cd, col_cd,
    toFloat64(sum(tot_out_qty)) AS color_tot_out_qty
  FROM outbound_qty_info
  GROUP BY sty_cd, col_cd
),

-- 최근 180일 기준 판매 일수 구하기 (기존 get_item_list.sql과 동일한 로직)
sales_days_180d AS (
  SELECT
    D.sty_cd,
    D.col_cd,
    D.size_cd,
    CASE
      WHEN date(MIN(FOD.first_outbound_date) + INTERVAL 1 DAY) <= addDays(toDate(parseDateTimeBestEffort('{{inputReferenceDate.value}}')), -179)
      THEN addDays(toDate(parseDateTimeBestEffort('{{inputReferenceDate.value}}')), -179)
      ELSE min(D.sale_dt)
    END AS first_sale_date_180d,
    max(D.sale_dt) AS last_sale_date_180d,
    -- 판매 일수 계산 (최대 180일까지)
    toFloat64(greatest(
      1,
      least(
        180,
        dateDiff('day', 
                 CASE
                   WHEN date(MIN(FOD.first_outbound_date) + INTERVAL 1 DAY) <= addDays(toDate(parseDateTimeBestEffort('{{inputReferenceDate.value}}')), -179)
                   THEN addDays(toDate(parseDateTimeBestEffort('{{inputReferenceDate.value}}')), -179)
                   ELSE min(D.sale_dt)
                 END, 
                 max(D.sale_dt)) + 1
      )
    )) AS sales_days_count_180d,
    -- 판매 월수 계산 (최대 6개월)
    toFloat64(least(
      6.0, -- 최대 6개월
      greatest(
        1.0/30.0, -- 최소 판매일이 하루라도 있으면 1/30개월
        (toFloat64(dateDiff('day', 
                   CASE
                     WHEN date(MIN(FOD.first_outbound_date) + INTERVAL 1 DAY) <= addDays(toDate(parseDateTimeBestEffort('{{inputReferenceDate.value}}')), -179)
                     THEN addDays(toDate(parseDateTimeBestEffort('{{inputReferenceDate.value}}')), -179)
                     ELSE min(D.sale_dt)
                   END, 
                   max(D.sale_dt)) + 1) / 30.0)
      )
    )) AS sales_months_count_180d
  FROM daily_data_by_size D
  INNER JOIN first_outbound_dates FOD ON D.sty_cd = FOD.sty_cd AND D.col_cd = FOD.col_cd AND D.size_cd = FOD.size_cd
  WHERE 
    FOD.first_outbound_date IS NOT NULL AND
    D.sale_dt >= date(FOD.first_outbound_date + INTERVAL 1 DAY) AND
    D.sale_dt >= addDays(toDate(parseDateTimeBestEffort('{{inputReferenceDate.value}}')), -179) AND
    D.sale_dt <= toDate(parseDateTimeBestEffort('{{inputReferenceDate.value}}')) AND
    D.sale_qty > 0  -- 실제 판매가 발생한 날짜만 고려
  GROUP BY D.sty_cd, D.col_cd, D.size_cd
),

-- 최근 180일 기준 월평균 판매량 (기존 get_item_list.sql과 동일한 로직)
daily_sales_180d AS (
  SELECT
    D.sty_cd AS sty_cd,
    D.col_cd AS col_cd,
    D.size_cd AS size_cd,
    toFloat64(sum(D.sale_qty)) AS total_180d_sale_qty,
    -- 일평균 계산
    CASE 
      WHEN SD180.sales_days_count_180d IS NOT NULL 
      THEN toFloat64(sum(D.sale_qty)) / SD180.sales_days_count_180d 
      ELSE toFloat64(0)
    END AS avg_daily_sales_d180,
    -- 월평균 계산 (총 판매량 / 판매 월수)
    CASE 
      WHEN SD180.sales_months_count_180d IS NOT NULL 
      THEN toFloat64(sum(D.sale_qty)) / SD180.sales_months_count_180d 
      ELSE toFloat64(0)
    END AS avg_monthly_sales_d180,
    SD180.first_sale_date_180d,
    SD180.last_sale_date_180d,
    SD180.sales_days_count_180d,
    SD180.sales_months_count_180d
  FROM daily_data_by_size D
  INNER JOIN first_outbound_dates FOD ON D.sty_cd = FOD.sty_cd AND D.col_cd = FOD.col_cd AND D.size_cd = FOD.size_cd
  LEFT JOIN sales_days_180d SD180 ON D.sty_cd = SD180.sty_cd AND D.col_cd = SD180.col_cd AND D.size_cd = SD180.size_cd
  WHERE 
    FOD.first_outbound_date IS NOT NULL AND
    D.sale_dt >= date(FOD.first_outbound_date + INTERVAL 1 DAY) AND
    D.sale_dt >= addDays(toDate(parseDateTimeBestEffort('{{inputReferenceDate.value}}')), -179) AND
    D.sale_dt <= toDate(parseDateTimeBestEffort('{{inputReferenceDate.value}}')) AND
    D.sale_qty > 0  
  GROUP BY 
    sty_cd, 
    col_cd, 
    size_cd, 
    SD180.sales_days_count_180d,
    SD180.sales_months_count_180d,
    SD180.first_sale_date_180d,
    SD180.last_sale_date_180d
),

-- 전체 판매 기간 계산 (기존 get_item_list.sql과 동일한 로직)
all_sales_periods AS (
  SELECT
    SI.sty_cd,
    SI.col_cd,
    SI.size_cd,
    CASE
      WHEN FOD.first_outbound_date IS NOT NULL THEN date(FOD.first_outbound_date + INTERVAL 1 DAY)
      ELSE NULL -- No defined start if no outbound date
    END AS first_sale_date_all,
    toDate(parseDateTimeBestEffort('{{inputReferenceDate.value}}')) AS last_sale_date_all, -- Period ends on reference date
    
    -- Calculate total sales days within this defined period
    CASE
      WHEN FOD.first_outbound_date IS NOT NULL AND (toDate(parseDateTimeBestEffort('{{inputReferenceDate.value}}')) >= date(FOD.first_outbound_date + INTERVAL 1 DAY))
      THEN toFloat64(dateDiff('day', date(FOD.first_outbound_date + INTERVAL 1 DAY), toDate(parseDateTimeBestEffort('{{inputReferenceDate.value}}'))) + 1)
      ELSE toFloat64(0) -- 0 days if period is invalid or first_outbound_date is null
    END AS total_sales_days,
    
    -- Calculate total sales months, ensuring at least 1 month if period is valid and has >0 days
    CASE
      WHEN FOD.first_outbound_date IS NOT NULL 
           AND (toDate(parseDateTimeBestEffort('{{inputReferenceDate.value}}')) >= date(FOD.first_outbound_date + INTERVAL 1 DAY)) -- Period is valid
           AND (dateDiff('day', date(FOD.first_outbound_date + INTERVAL 1 DAY), toDate(parseDateTimeBestEffort('{{inputReferenceDate.value}}'))) + 1) > 0 -- Days in period > 0
      THEN toFloat64(greatest(1.0, (toFloat64(dateDiff('day', date(FOD.first_outbound_date + INTERVAL 1 DAY), toDate(parseDateTimeBestEffort('{{inputReferenceDate.value}}'))) + 1) / 30.0)))
      ELSE toFloat64(0) -- 0 months if period is invalid or results in 0 days
    END AS total_sales_months
  FROM 
    (SELECT DISTINCT sty_cd, col_cd, size_cd FROM daily_data_by_size WHERE sale_qty > 0) SI -- Consider only items with actual sales history
  LEFT JOIN 
    first_outbound_dates FOD ON SI.sty_cd = FOD.sty_cd AND SI.col_cd = FOD.col_cd AND SI.size_cd = FOD.size_cd
),

-- 전체 기간 판매량 및 월평균 판매량 (기존 get_item_list.sql과 동일한 로직)
all_time_sales AS (
  SELECT
    ASP.sty_cd, -- Use sty_cd from ASP to ensure we're aligned with the defined periods
    ASP.col_cd,
    ASP.size_cd,
    -- Sum sales quantity only within the defined period [ASP.first_sale_date_all, ASP.last_sale_date_all]
    toFloat64(sum(CASE 
                    WHEN D.sale_dt >= ASP.first_sale_date_all AND D.sale_dt <= ASP.last_sale_date_all
                    THEN D.sale_qty 
                    ELSE 0 
                  END)) AS total_all_time_sale_qty,
    
    -- 일평균 계산 (판매 일수가 0 또는 NULL이면 0으로 처리)
    CASE 
      WHEN ASP.total_sales_days IS NOT NULL AND ASP.total_sales_days > 0
      THEN toFloat64(sum(CASE WHEN D.sale_dt >= ASP.first_sale_date_all AND D.sale_dt <= ASP.last_sale_date_all THEN D.sale_qty ELSE 0 END)) / ASP.total_sales_days 
      ELSE toFloat64(0) 
    END AS avg_daily_sales,
    
    -- 월평균 계산 (판매 월수가 0 또는 NULL이면 0으로 처리)
    CASE 
      WHEN ASP.total_sales_months IS NOT NULL AND ASP.total_sales_months > 0
      THEN toFloat64(sum(CASE WHEN D.sale_dt >= ASP.first_sale_date_all AND D.sale_dt <= ASP.last_sale_date_all THEN D.sale_qty ELSE 0 END)) / ASP.total_sales_months
      ELSE toFloat64(0)
    END AS avg_monthly_sales,
    
    ASP.first_sale_date_all,
    ASP.last_sale_date_all,
    ASP.total_sales_days,
    ASP.total_sales_months
  FROM all_sales_periods ASP
  LEFT JOIN daily_data_by_size D ON 
    ASP.sty_cd = D.sty_cd AND 
    ASP.col_cd = D.col_cd AND 
    ASP.size_cd = D.size_cd AND
    D.sale_qty > 0 -- Only consider days with actual sales
  WHERE 
    ASP.first_sale_date_all IS NOT NULL AND -- Process only if a valid period start date exists
    D.sale_dt >= ASP.first_sale_date_all AND 
    D.sale_dt <= ASP.last_sale_date_all -- Filter sales by the period from ASP
  GROUP BY 
    ASP.sty_cd, 
    ASP.col_cd, 
    ASP.size_cd, 
    ASP.first_sale_date_all, 
    ASP.last_sale_date_all, 
    ASP.total_sales_days, 
    ASP.total_sales_months
),

-- Helper CTE for the reference week start date (week 1) - 기존 get_item_list.sql과 동일
_ref_week_start_cte AS (
    SELECT toStartOfWeek(
        CASE
            WHEN toDayOfWeek(today()) = 1 THEN addDays(today(), -7) -- If today is Monday, week 1 is last week's Monday
            ELSE today() -- Otherwise, week 1 is this week's Monday
        END,
        1
    ) AS ref_week_start_val
),

-- Source for weekly sales, covering the 12 relevant weeks for pivoting - 기존 get_item_list.sql과 동일
weekly_sales_source AS (
  SELECT
    sty_cd,
    col_cd,
    size_cd,
    toStartOfWeek(sale_dt, 1) AS week_start,
    toFloat64(sum(sale_qty)) AS weekly_sale_qty
  FROM daily_data_by_size
  WHERE sale_dt < today() -- Sales up to yesterday
    -- Filter for the 12 weeks ending with the reference week 1
    AND toStartOfWeek(sale_dt, 1) >= addWeeks((SELECT ref_week_start_val FROM _ref_week_start_cte), -11) -- Oldest week (week 12)
    AND toStartOfWeek(sale_dt, 1) <= (SELECT ref_week_start_val FROM _ref_week_start_cte) -- Most recent week (week 1)
  GROUP BY sty_cd, col_cd, size_cd, week_start
),

-- Pivoted weekly sales: one row per item, with sales for each of the last 12 weeks in separate columns - 기존 get_item_list.sql과 동일
weekly_sales_pivoted AS (
  SELECT
    sty_cd,
    col_cd,
    size_cd,
    sum(IF(week_start = (SELECT ref_week_start_val FROM _ref_week_start_cte), weekly_sale_qty, 0)) AS week_1_sale_qty,
    sum(IF(week_start = addWeeks((SELECT ref_week_start_val FROM _ref_week_start_cte), -1), weekly_sale_qty, 0)) AS week_2_sale_qty,
    sum(IF(week_start = addWeeks((SELECT ref_week_start_val FROM _ref_week_start_cte), -2), weekly_sale_qty, 0)) AS week_3_sale_qty,
    sum(IF(week_start = addWeeks((SELECT ref_week_start_val FROM _ref_week_start_cte), -3), weekly_sale_qty, 0)) AS week_4_sale_qty,
    sum(IF(week_start = addWeeks((SELECT ref_week_start_val FROM _ref_week_start_cte), -4), weekly_sale_qty, 0)) AS week_5_sale_qty,
    sum(IF(week_start = addWeeks((SELECT ref_week_start_val FROM _ref_week_start_cte), -5), weekly_sale_qty, 0)) AS week_6_sale_qty,
    sum(IF(week_start = addWeeks((SELECT ref_week_start_val FROM _ref_week_start_cte), -6), weekly_sale_qty, 0)) AS week_7_sale_qty,
    sum(IF(week_start = addWeeks((SELECT ref_week_start_val FROM _ref_week_start_cte), -7), weekly_sale_qty, 0)) AS week_8_sale_qty,
    sum(IF(week_start = addWeeks((SELECT ref_week_start_val FROM _ref_week_start_cte), -8), weekly_sale_qty, 0)) AS week_9_sale_qty,
    sum(IF(week_start = addWeeks((SELECT ref_week_start_val FROM _ref_week_start_cte), -9), weekly_sale_qty, 0)) AS week_10_sale_qty,
    sum(IF(week_start = addWeeks((SELECT ref_week_start_val FROM _ref_week_start_cte), -10), weekly_sale_qty, 0)) AS week_11_sale_qty,
    sum(IF(week_start = addWeeks((SELECT ref_week_start_val FROM _ref_week_start_cte), -11), weekly_sale_qty, 0)) AS week_12_sale_qty
  FROM weekly_sales_source
  GROUP BY sty_cd, col_cd, size_cd
),

-- 매장 수 정보
shop_count_data AS (
  SELECT count(DISTINCT S.shop_cd) AS active_shop_count
  FROM agabang_dw.daily_shop_sales_by_dimension S
  INNER JOIN agabang_dw.prod_sales_stock_by_color P ON S.sty_cd = P.sty_cd
  WHERE S.sale_dt >= addYears(today(), -1)
    AND S.sale_dt < today()
    AND S.sale_gb = '매장판매'
    AND S.it NOT IN (6, 8, 9)
    AND (
      ('{{ var_brand_code.value }}' = '01' AND substring(S.sty_cd, 3, 1) = substring('{{ select_season.value}}', 1, 1)
       AND S.season_cd in (substring('{{ select_season.value}}', 2, 1)) AND (
        ('{{ select_brand.value }}' = 'all' AND S.br_cd = '01') OR
        ('{{ select_brand.value }}' = 'agabang' AND S.br_cd = '01')
      )) OR
      ('{{ var_brand_code.value }}' = '07' AND substring(S.sty_cd, 3, 1) >= 'M' AND (
        S.br_cd = '07' AND (
          '{{ select_brand.value }}' = 'all' OR
          ('{{ select_brand.value }}' = 'liewood' AND S.sub_br_nm in ('리우드', '오비디자인스', '노바디노즈')) OR
          ('{{ select_brand.value }}' = 'ettoi' AND S.sub_br_nm not in ('리우드', '오비디자인스', '노바디노즈'))
        )
      )) OR
      ('{{ var_brand_code.value }}' = '79' AND (
        ('{{ select_brand.value }}' = 'all' AND S.br_cd = '79') OR
        ('{{ select_brand.value }}' = 'disney' AND S.br_cd = '79')
      ))
    )
)

SELECT
  -- 기본 상품 정보
  S.sty_cd AS sty_cd, S.sty_nm AS sty_nm, S.col_cd AS col_cd, S.col_nm AS col_nm, S.size_cd AS size_cd, S.size_nm AS size_nm,
  'series_name_placeholder' AS series_name,
  S.tag_price AS tag_price, S.cost_price AS cost_price, S.large_cat AS large_cat, S.middle_cat AS middle_cat, S.small_cat AS small_cat,
  S.it AS it, S.it_nm AS it_nm, S.it_gb AS it_gb, S.it_gb_nm AS it_gb_nm, S.item AS item, S.item_nm AS item_nm, S.first_sales_dt AS first_sales_dt,
  S.cust_cd AS cust_cd, S.cust_nm AS cust_nm, S.br_nm AS br_nm, S.fabric AS fabric,
  
  -- 재고 정보
  toFloat64(P.tot_in_qty) AS tot_in_qty,
  toFloat64(P.tot_sale_qty) AS tot_sale_qty,
  toFloat64(P.tot_in_qty - P.tot_sale_qty) AS current_stock_qty,
  toFloat64(P.wh_stck_qty) AS wh_stck_qty,
  toFloat64(P.sh_stck_qty) AS sh_stck_qty,
  
  -- 출고량 (JOIN으로 해결)
  COALESCE(OQI.tot_out_qty, toFloat64(0)) AS tot_out_qty,
  
  -- 컬러별 합계 (JOIN으로 해결)
  COALESCE(CS.color_tot_in_qty, toFloat64(0)) AS color_tot_in_qty,
  COALESCE(CS.color_tot_sale_qty, toFloat64(0)) AS color_tot_sale_qty,
  COALESCE(CS.color_current_stock, toFloat64(0)) AS color_current_stock,
  COALESCE(CS.color_wh_stck_qty, toFloat64(0)) AS color_wh_stck_qty,
  COALESCE(CS.color_sh_stck_qty, toFloat64(0)) AS color_sh_stck_qty,
  COALESCE(CO.color_tot_out_qty, toFloat64(0)) AS color_tot_out_qty,
  
  -- 입고/출고 날짜 (JOIN으로 해결)
  DS.first_inventory_date,
  DS.last_inventory_date,
  FOD.first_outbound_date,
  
  -- 판매 통계 (JOIN으로 해결)
  COALESCE(DS.pure_sales_7d, toFloat64(0)) AS pure_total_7d_sale_qty,
  
  -- 7일 판매량 (브랜드 조건 포함)
  COALESCE(DS.sales_7d, toFloat64(0)) AS sales_qty_7d,
  
  -- 7일 일평균 (원본과 동일한 로직: 실제 판매 일수로 나누기)
  multiIf(DS.sales_days_7d > 0, DS.sales_7d / DS.sales_days_7d, toFloat64(0)) AS avg_daily_sales_d7,
  
  COALESCE(DS.sales_30d, toFloat64(0)) AS sales_qty_30d,
  COALESCE(DS180.total_180d_sale_qty, toFloat64(0)) AS sales_qty_180d,
  COALESCE(DS.sales_365d, toFloat64(0)) AS sales_qty_365d,
  
  -- 전체 기간 판매량 (원본과 동일: first_outbound_date + 1일부터)
  COALESCE(ATS.total_all_time_sale_qty, toFloat64(0)) AS total_all_time_sale_qty,
  
  -- 판매 일수
  COALESCE(DS.sales_days_7d, toFloat64(0)) AS sales_days_count_7d,
  COALESCE(DS.sales_days_30d, toFloat64(0)) AS sales_days_count_30d,
  COALESCE(DS180.sales_days_count_180d, toFloat64(0)) AS sales_days_count_180d,
  COALESCE(DS.sales_days_365d, toFloat64(0)) AS sales_days_count_365d,
  
  -- 전체 기간 판매 일수 (기존 get_item_list.sql과 동일한 방식)
  COALESCE(ATS.total_sales_days, toFloat64(0)) AS total_sales_days,
  
  -- 기간별 실제 판매 날짜
  DS.first_sale_date_7d,
  DS.last_sale_date_7d,
  DS.first_sale_date_30d,
  DS.last_sale_date_30d,
  DS180.first_sale_date_180d,
  DS180.last_sale_date_180d,
  DS.first_sale_date_365d,
  DS.last_sale_date_365d,
  
  -- 판매 월수 추가 (더 정확한 계산)
  multiIf(DS.first_sale_date_30d IS NOT NULL AND DS.last_sale_date_30d IS NOT NULL, 
    toFloat64(dateDiff('month', DS.first_sale_date_30d, DS.last_sale_date_30d) + 1), 
    toFloat64(0)) AS sales_months_count_30d,
  COALESCE(DS180.sales_months_count_180d, toFloat64(0)) AS sales_months_count_180d,
  multiIf(DS.first_sale_date_365d IS NOT NULL AND DS.last_sale_date_365d IS NOT NULL, 
    toFloat64(dateDiff('month', DS.first_sale_date_365d, DS.last_sale_date_365d) + 1), 
    toFloat64(0)) AS sales_months_count_365d,
  -- 전체 기간 판매 월수 (기존 get_item_list.sql과 동일한 방식)
  COALESCE(ATS.total_sales_months, toFloat64(0)) AS total_sales_months,
  
  -- 평균 판매량 계산 (0으로 나누기 방지)
  multiIf(DS.sales_days_30d > 0, DS.sales_30d / DS.sales_days_30d, toFloat64(0)) AS avg_daily_sales_d30,
  COALESCE(DS180.avg_daily_sales_d180, toFloat64(0)) AS avg_daily_sales_d180,
  multiIf(DS.sales_days_365d > 0, DS.sales_365d / DS.sales_days_365d, toFloat64(0)) AS avg_daily_sales_d365,
  
  -- 월평균 (30일을 월평균으로, 180일/6개월, 365일/12개월)
  COALESCE(DS.sales_30d, toFloat64(0)) AS avg_monthly_sales_d30,
  COALESCE(DS180.avg_monthly_sales_d180, toFloat64(0)) AS avg_monthly_sales_d180,
  multiIf(DS.sales_365d > 0, DS.sales_365d / 12.0, toFloat64(0)) AS avg_monthly_sales_d365,
  
  -- 전체 기간 평균 (기존 get_item_list.sql과 동일한 방식)
  COALESCE(ATS.avg_daily_sales, toFloat64(0)) AS avg_daily_sales,
  
  -- 전체 기간 월평균 (기존 get_item_list.sql과 동일한 방식)
  COALESCE(ATS.avg_monthly_sales, toFloat64(0)) AS avg_monthly_sales,
  
  -- 기간별 날짜
  ATS.first_sale_date_all,
  ATS.last_sale_date_all,
  
  -- 판매율
  multiIf(P.tot_in_qty > 0, toFloat64(P.tot_sale_qty) / toFloat64(P.tot_in_qty), toFloat64(0)) AS sale_rate,
  
  -- 주간 판매량 (최근 12주) - 기존 get_item_list.sql과 동일한 방식
  COALESCE(WSP.week_1_sale_qty, toFloat64(0)) AS week_1_sale_qty,
  COALESCE(WSP.week_2_sale_qty, toFloat64(0)) AS week_2_sale_qty,
  COALESCE(WSP.week_3_sale_qty, toFloat64(0)) AS week_3_sale_qty,
  COALESCE(WSP.week_4_sale_qty, toFloat64(0)) AS week_4_sale_qty,
  COALESCE(WSP.week_5_sale_qty, toFloat64(0)) AS week_5_sale_qty,
  COALESCE(WSP.week_6_sale_qty, toFloat64(0)) AS week_6_sale_qty,
  COALESCE(WSP.week_7_sale_qty, toFloat64(0)) AS week_7_sale_qty,
  COALESCE(WSP.week_8_sale_qty, toFloat64(0)) AS week_8_sale_qty,
  COALESCE(WSP.week_9_sale_qty, toFloat64(0)) AS week_9_sale_qty,
  COALESCE(WSP.week_10_sale_qty, toFloat64(0)) AS week_10_sale_qty,
  COALESCE(WSP.week_11_sale_qty, toFloat64(0)) AS week_11_sale_qty,
  COALESCE(WSP.week_12_sale_qty, toFloat64(0)) AS week_12_sale_qty,
  
  -- 기타 상수 정보
  toFloat64(60) AS lead_time_days,
  toFloat64(0.8) AS target_sale_rate,
  toFloat64(1000) AS moq,
  toFloat64(3) AS expected_sales_period_months,
  (SELECT active_shop_count FROM shop_count_data) AS active_shop_count

FROM dim_style S
INNER JOIN prod_sales_stock_by_size P ON S.sty_cd = P.sty_cd AND S.col_cd = P.col_cd AND S.size_cd = P.size_cd
LEFT JOIN daily_stats DS ON S.sty_cd = DS.sty_cd AND S.col_cd = DS.col_cd AND S.size_cd = DS.size_cd
LEFT JOIN first_outbound_dates FOD ON S.sty_cd = FOD.sty_cd AND S.col_cd = FOD.col_cd AND S.size_cd = FOD.size_cd
LEFT JOIN all_time_sales ATS ON S.sty_cd = ATS.sty_cd AND S.col_cd = ATS.col_cd AND S.size_cd = ATS.size_cd
LEFT JOIN daily_sales_180d DS180 ON S.sty_cd = DS180.sty_cd AND S.col_cd = DS180.col_cd AND S.size_cd = DS180.size_cd
LEFT JOIN outbound_qty_info OQI ON S.sty_cd = OQI.sty_cd AND S.col_cd = OQI.col_cd AND S.size_cd = OQI.size_cd
LEFT JOIN color_stats CS ON S.sty_cd = CS.sty_cd AND S.col_cd = CS.col_cd
LEFT JOIN color_outbound CO ON S.sty_cd = CO.sty_cd AND S.col_cd = CO.col_cd
LEFT JOIN weekly_sales_pivoted WSP ON S.sty_cd = WSP.sty_cd AND S.col_cd = WSP.col_cd AND S.size_cd = WSP.size_cd

WHERE substring(S.sty_cd, 3, 1) = substring('{{ select_season.value}}', 1, 1)
  AND S.season_cd in (substring('{{ select_season.value}}', 2, 1))
  AND S.it NOT IN (6, 8, 9)
  AND (
    {{ !cascaderNew1.value || cascaderNew1.value == "" || cascaderNew1.value == "_ALL_" }}
    OR (
      S.large_cat = '{{ parse_cascader_path.data.large_cat }}'
      {{ parse_cascader_path.data.middle_cat && !parse_cascader_path.data.middle_all && !parse_cascader_path.data.is_brand_07 && !parse_cascader_path.data.is_middle_null ? "AND S.middle_cat = '" + parse_cascader_path.data.middle_cat + "'" : "" }}
      {{ parse_cascader_path.data.small_cat && !parse_cascader_path.data.small_all ? "AND S.small_cat = '" + parse_cascader_path.data.small_cat + "'" : "" }}
    )
  )
  AND (
    ('{{ var_brand_code.value }}' = '01' AND substring(S.sty_cd, 3, 1) >= 'J' AND (
      ('{{ select_brand.value }}' = 'all' AND S.br_cd = '01') OR
      ('{{ select_brand.value }}' = 'agabang' AND S.br_cd = '01')
    )) OR
    ('{{ var_brand_code.value }}' = '07' AND substring(S.sty_cd, 3, 1) >= 'M' AND (
      S.br_cd = '07' AND (
        '{{ select_brand.value }}' = 'all' OR
        ('{{ select_brand.value }}' = 'liewood' AND S.sub_br_nm in ('리우드', '오비디자인스', '노바디노즈')) OR
        ('{{ select_brand.value }}' = 'ettoi' AND S.sub_br_nm not in ('리우드', '오비디자인스', '노바디노즈'))
      )
    )) OR
    ('{{ var_brand_code.value }}' = '79' AND (
      ('{{ select_brand.value }}' = 'all' AND S.br_cd = '79') OR
      ('{{ select_brand.value }}' = 'disney' AND S.br_cd = '79')
    ))
  )
  AND P.tot_in_qty > 0
  AND (P.tot_in_qty - P.tot_sale_qty) >= 0

ORDER BY S.sty_cd, S.col_cd, S.size_cd