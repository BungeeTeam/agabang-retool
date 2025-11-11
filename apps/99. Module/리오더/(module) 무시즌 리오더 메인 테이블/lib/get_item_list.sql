-- get_item_list
WITH base_products AS 
(
  SELECT DISTINCT
    S.comp_cd,
    S.sty_cd,
    S.sty_nm,
    S.col_cd,
    S.col_nm,
    S.size_cd,
    S.size_nm,
    S.large_cat,
    S.middle_cat,
    S.small_cat,
    S.it,
    S.it_nm,
    S.it_gb,
    S.it_gb_nm,
    S.item,
    S.item_nm,
    S.tag_price,  -- 판매가
    S.cost_price, -- 원가
    S.br_cd,
    S.br_nm,
    S.season_cd,
    S.season_nm,
    S.first_sales_dt, -- 최초 판매일
    S.cust_cd,    -- 생산처코드
    S.cust_nm,    -- 생산처명 
    S.fabric,     -- 소재
    'series_name_placeholder' AS series_name -- 실제 구현 시 시리즈명 로직 연결
  FROM dim_style S
  INNER JOIN prod_sales_stock_by_color P ON S.sty_cd = P.sty_cd AND S.col_cd = P.col_cd
  WHERE S.season_cd = '0'
    AND S.it NOT IN (6, 8, 9)
    AND (
  {{ !cascaderNew1.value || cascaderNew1.value == "" || cascaderNew1.value == "_ALL_" }}
  OR (
    S.large_cat = '{{ parse_cascader_path.data.large_cat }}'
    -- br_cd = '07'이거나 '0코드'인 경우 중분류 조건 스킵
    {{ parse_cascader_path.data.middle_cat && !parse_cascader_path.data.middle_all && !parse_cascader_path.data.is_brand_07 && !parse_cascader_path.data.is_middle_null ? "AND S.middle_cat = '" + parse_cascader_path.data.middle_cat + "'" : "" }}
    {{ parse_cascader_path.data.small_cat && !parse_cascader_path.data.small_all ? "AND S.small_cat = '" + parse_cascader_path.data.small_cat + "'" : "" }}
  )
)

    AND (
      ('{{ var_brand_code.value }}' = '01'
      AND substring(S.sty_cd, 3, 1) >= 'J'
      AND (
        ('{{ select_brand.value }}' = 'all'
            AND S.br_cd = '01') OR
        ('{{ select_brand.value }}' = 'agabang'
            AND S.br_cd = '01')
      ))
    OR
      ('{{ var_brand_code.value }}' = '07'
      AND substring(S.sty_cd, 3, 1) >= 'M'
      AND (
        S.br_cd = '07'  AND
        (
          '{{ select_brand.value }}' = 'all' OR
          ('{{ select_brand.value }}' = 'liewood' AND (
            S.sub_br_nm in ('리우드', '오비디자인스', '노바디노즈')
          )) OR
          ('{{ select_brand.value }}' = 'ettoi' AND
            S.sub_br_nm not in ('리우드', '오비디자인스', '노바디노즈')
          )
        )
      ))
    )
),

shop_count_data AS (
  SELECT count(DISTINCT S.shop_cd) AS active_shop_count
  FROM agabang_dw.daily_shop_sales_by_dimension S
  INNER JOIN agabang_dw.prod_sales_stock_by_color P ON S.sty_cd = P.sty_cd
  WHERE S.sale_dt >= date_sub(today(), interval 1 year)
    AND S.sale_dt < today()  -- 어제까지
    AND S.sale_gb = '매장판매'
    AND S.season_cd = '0'
    AND S.it NOT IN (6, 8, 9)
    AND (
      ('{{ var_brand_code.value }}' = '01'
      AND substring(S.sty_cd, 3, 1) >= 'J'
      AND (
        ('{{ select_brand.value }}' = 'all'
            AND S.br_cd = '01') OR
        ('{{ select_brand.value }}' = 'agabang'
            AND S.br_cd = '01')
      ))
    OR
      ('{{ var_brand_code.value }}' = '07'
      AND substring(S.sty_cd, 3, 1) >= 'M'
      AND (
        S.br_cd = '07'  AND
        (
          '{{ select_brand.value }}' = 'all' OR
          ('{{ select_brand.value }}' = 'liewood' AND (
            S.sub_br_nm in ('리우드', '오비디자인스', '노바디노즈')
          )) OR
          ('{{ select_brand.value }}' = 'ettoi' AND
            S.sub_br_nm not in ('리우드', '오비디자인스', '노바디노즈')
          )
        )
      ))
    )
),

stock_info AS 
(
  SELECT
    P.sty_cd,
    P.col_cd,
    P.size_cd,
    toFloat64(P.tot_in_qty) AS tot_in_qty,
    toFloat64(P.tot_sale_qty) AS tot_sale_qty,
    toFloat64(P.tot_in_qty - P.tot_sale_qty) AS current_stock_qty,
    P.tag_prce,
    P.cost_prce,
    toFloat64(P.wh_stck_qty) AS wh_stck_qty,
    toFloat64(P.sh_stck_qty) AS sh_stck_qty
  FROM prod_sales_stock_by_size P
  WHERE tot_in_qty > 0
),
-- 1. 사이즈별 첫 입고일과 마지막 입고일
inventory_dates AS 
(
  SELECT
    D.sty_cd,
    D.col_cd,
    D.size_cd,
    min(D.sale_dt) AS first_inventory_date,
    max(D.sale_dt) AS last_inventory_date
  FROM daily_data_by_size D
  WHERE D.in_qty > 0  -- 입고 수량이 있는 날짜만 고려
  GROUP BY D.sty_cd, D.col_cd, D.size_cd
),

-- CTE 추가: 첫 출고일 데이터 가져오기
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

-- NEW: 총 출고량 정보 추가
outbound_qty_info AS (
  SELECT
    D.sty_cd,
    D.col_cd,
    D.size_cd,
    toFloat64(sum(D.out_qty)) AS tot_out_qty  -- 총 출고량
  FROM daily_data_by_size D
  GROUP BY D.sty_cd, D.col_cd, D.size_cd
),

-- NEW: 컬러별 출고량 합계
color_outbound_totals AS (
  SELECT
    sty_cd,
    col_cd,
    toFloat64(sum(tot_out_qty)) AS color_tot_out_qty
  FROM outbound_qty_info
  GROUP BY sty_cd, col_cd
),

-- 2. 총 리오더 횟수 계산 (수정된 버전)
large_inventory_days AS 
(
  -- 일별 입고 데이터에서 50개 이상 입고된 날짜 추출
  SELECT
    sty_cd,
    col_cd,
    size_cd,
    sale_dt
  FROM daily_data_by_size
  WHERE in_qty >= 50  -- 50개 이상 입고된 경우
),

-- 3. 전체 판매 기간 계산
all_sales_periods AS 
(
  -- 각 상품의 전체 판매 기간 계산
  SELECT
    D.sty_cd,
    D.col_cd,
    D.size_cd,
    min(D.sale_dt) AS first_sale_date_all,
    max(D.sale_dt) AS last_sale_date_all,
    -- 판매 일수 계산 (최소 1일)
    toFloat64(greatest(
      1,
      dateDiff('day', min(D.sale_dt), max(D.sale_dt)) + 1
    )) AS total_sales_days,
    -- 판매 월수 계산 (최소 1개월, 일수 / 30)
    toFloat64(greatest(
      1,
      (dateDiff('day', min(D.sale_dt), max(D.sale_dt)) + 1) / 30
    )) AS total_sales_months
  FROM daily_data_by_size D
  WHERE D.sale_qty > 0  -- 실제 판매가 발생한 날짜만 고려
  GROUP BY D.sty_cd, D.col_cd, D.size_cd
),
-- 4. 전체 기간 판매량 및 월평균 판매량
all_time_sales AS 
(
  SELECT
    D.sty_cd,
    D.col_cd,
    D.size_cd,
    toFloat64(sum(D.sale_qty)) AS total_all_time_sale_qty,
    -- 일평균 계산 (판매 일수가 없으면 0으로 처리)
    CASE 
      WHEN ASP.total_sales_days IS NOT NULL 
      THEN toFloat64(sum(D.sale_qty)) / ASP.total_sales_days 
      ELSE toFloat64(0) 
    END AS avg_daily_sales,
    -- 월평균 계산 (일평균 * 30 또는 총 판매량 / 판매 월수)
    CASE 
      WHEN ASP.total_sales_months IS NOT NULL 
      THEN toFloat64(sum(D.sale_qty)) / ASP.total_sales_months 
      ELSE toFloat64(0)
    END AS avg_monthly_sales,
    ASP.first_sale_date_all,
    ASP.last_sale_date_all,
    ASP.total_sales_days,
    ASP.total_sales_months
  FROM daily_data_by_size D
  LEFT JOIN all_sales_periods ASP ON 
    D.sty_cd = ASP.sty_cd AND 
    D.col_cd = ASP.col_cd AND 
    D.size_cd = ASP.size_cd
  GROUP BY 
    D.sty_cd, 
    D.col_cd, 
    D.size_cd, 
    ASP.total_sales_days,
    ASP.total_sales_months,
    ASP.first_sale_date_all,
    ASP.last_sale_date_all
),
-- 5. 최근 30일 기준 판매 일수 구하기
sales_days_30d AS 
(
  SELECT
    D.sty_cd,
    D.col_cd,
    D.size_cd,
    min(D.sale_dt) AS first_sale_date_30d,
    max(D.sale_dt) AS last_sale_date_30d,
    -- 판매 일수 계산 (최대 30일까지)
    toFloat64(greatest(
      1,
      least(
        30, 
        dateDiff('day', min(D.sale_dt), max(D.sale_dt)) + 1
      )
    )) AS sales_days_count_30d,
    -- 판매 월수 계산 (최대 1개월)
    toFloat64(1) AS sales_months_count_30d
  FROM daily_data_by_size D
  WHERE D.sale_dt >= addDays(today(), -31)
    AND D.sale_dt < today()  -- 어제까지
    AND D.sale_qty > 0  -- 실제 판매가 발생한 날짜만 고려
  GROUP BY D.sty_cd, D.col_cd, D.size_cd
),
-- 6. 최근 30일 기준 월평균 판매량
daily_sales_30d AS 
(
  SELECT
    D.sty_cd,
    D.col_cd,
    D.size_cd,
    toFloat64(sum(D.sale_qty)) AS total_30d_sale_qty,
    -- 일평균 계산 (판매 일수가 없으면 0으로 처리)
    CASE 
      WHEN SD30.sales_days_count_30d IS NOT NULL 
      THEN toFloat64(sum(D.sale_qty)) / SD30.sales_days_count_30d 
      ELSE toFloat64(0)
    END AS avg_daily_sales_d30,
    -- 월평균 계산 (30일 판매량을 그대로 월평균으로 처리)
    toFloat64(sum(D.sale_qty)) AS avg_monthly_sales_d30,
    SD30.first_sale_date_30d,
    SD30.last_sale_date_30d,
    SD30.sales_days_count_30d,
    SD30.sales_months_count_30d
  FROM daily_data_by_size D
  LEFT JOIN sales_days_30d SD30 ON 
    D.sty_cd = SD30.sty_cd AND 
    D.col_cd = SD30.col_cd AND 
    D.size_cd = SD30.size_cd
  WHERE D.sale_dt >= addDays(today(), -31)
    AND D.sale_dt < today()  -- 어제까지
  GROUP BY 
    D.sty_cd, 
    D.col_cd, 
    D.size_cd, 
    SD30.sales_days_count_30d,
    SD30.sales_months_count_30d,
    SD30.first_sale_date_30d,
    SD30.last_sale_date_30d
),
-- 7. 최근 180일 기준 판매 일수 및 월수 구하기
sales_days_180d AS 
(
  SELECT
    D.sty_cd,
    D.col_cd,
    D.size_cd,
    min(D.sale_dt) AS first_sale_date_180d,
    max(D.sale_dt) AS last_sale_date_180d,
    -- 판매 일수 계산 (최대 180일까지)
    toFloat64(greatest(
      1,
      least(
        180, 
        dateDiff('day', min(D.sale_dt), max(D.sale_dt)) + 1
      )
    )) AS sales_days_count_180d,
    -- 판매 월수 계산 (최대 6개월)
    toFloat64(greatest(
      1,
      least(
        6,
        (dateDiff('day', min(D.sale_dt), max(D.sale_dt)) + 1) / 30
      )
    )) AS sales_months_count_180d
  FROM daily_data_by_size D
  WHERE D.sale_dt >= addDays(today(), -181)
    AND D.sale_dt < today()  -- 어제까지
    AND D.sale_qty > 0  -- 실제 판매가 발생한 날짜만 고려
  GROUP BY D.sty_cd, D.col_cd, D.size_cd
),
-- 8. 최근 180일 기준 월평균 판매량
daily_sales_180d AS 
(
  SELECT
    D.sty_cd,
    D.col_cd,
    D.size_cd,
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
  LEFT JOIN sales_days_180d SD180 ON 
    D.sty_cd = SD180.sty_cd AND 
    D.col_cd = SD180.col_cd AND 
    D.size_cd = SD180.size_cd
  WHERE D.sale_dt >= addDays(today(), -181)
    AND D.sale_dt < today()  -- 어제까지
  GROUP BY 
    D.sty_cd, 
    D.col_cd, 
    D.size_cd, 
    SD180.sales_days_count_180d,
    SD180.sales_months_count_180d,
    SD180.first_sale_date_180d,
    SD180.last_sale_date_180d
),
-- 9. 최근 365일 기준 판매 일수 및 월수 구하기
sales_days_365d AS 
(
  SELECT
    D.sty_cd,
    D.col_cd,
    D.size_cd,
    min(D.sale_dt) AS first_sale_date_365d,
    max(D.sale_dt) AS last_sale_date_365d,
    -- 판매 일수 계산 (최대 365일까지)
    toFloat64(greatest(
      1,
      least(
        365, 
        dateDiff('day', min(D.sale_dt), max(D.sale_dt)) + 1
      )
    )) AS sales_days_count_365d,
    -- 판매 월수 계산 (최대 12개월)
    toFloat64(greatest(
      1,
      least(
        12,
        (dateDiff('day', min(D.sale_dt), max(D.sale_dt)) + 1) / 30
      )
    )) AS sales_months_count_365d
  FROM daily_data_by_size D
  WHERE D.sale_dt >= addDays(today(), -366)
    AND D.sale_dt < today()  -- 어제까지
    AND D.sale_qty > 0  -- 실제 판매가 발생한 날짜만 고려
  GROUP BY D.sty_cd, D.col_cd, D.size_cd
),
-- 10. 최근 365일 기준 월평균 판매량
daily_sales_365d AS 
(
  SELECT
    D.sty_cd,
    D.col_cd,
    D.size_cd,
    toFloat64(sum(D.sale_qty)) AS total_365d_sale_qty,
    -- 일평균 계산
    CASE 
      WHEN SD365.sales_days_count_365d IS NOT NULL 
      THEN toFloat64(sum(D.sale_qty)) / SD365.sales_days_count_365d 
      ELSE toFloat64(0)
    END AS avg_daily_sales_d365,
    -- 월평균 계산 (총 판매량 / 판매 월수)
    CASE 
      WHEN SD365.sales_months_count_365d IS NOT NULL 
      THEN toFloat64(sum(D.sale_qty)) / SD365.sales_months_count_365d 
      ELSE toFloat64(0)
    END AS avg_monthly_sales_d365,
    SD365.first_sale_date_365d,
    SD365.last_sale_date_365d,
    SD365.sales_days_count_365d,
    SD365.sales_months_count_365d
  FROM daily_data_by_size D
  LEFT JOIN sales_days_365d SD365 ON 
    D.sty_cd = SD365.sty_cd AND 
    D.col_cd = SD365.col_cd AND 
    D.size_cd = SD365.size_cd
  WHERE D.sale_dt >= addDays(today(), -366)
    AND D.sale_dt < today()  -- 어제까지
  GROUP BY 
    D.sty_cd, 
    D.col_cd, 
    D.size_cd, 
    SD365.sales_days_count_365d,
    SD365.sales_months_count_365d,
    SD365.first_sale_date_365d,
    SD365.last_sale_date_365d
),

-- 최근 7일 기준 판매 일수 구하기
sales_days_7d AS 
(
  SELECT
    D.sty_cd,
    D.col_cd,
    D.size_cd,
    min(D.sale_dt) AS first_sale_date_7d,
    max(D.sale_dt) AS last_sale_date_7d,
    -- 판매 일수 계산 (최대 7일까지)
    toFloat64(greatest(
      1,
      least(
        7, 
        dateDiff('day', min(D.sale_dt), max(D.sale_dt)) + 1
      )
    )) AS sales_days_count_7d,
    -- 판매 주수 계산 (최대 1주)
    toFloat64(1) AS sales_weeks_count_7d
  FROM daily_data_by_size D
  WHERE D.br_cd = '{{ var_brand_code.value }}'
    AND D.sale_dt >= addDays(today(), -8)
    AND D.sale_dt < today()  -- 어제까지
    AND D.sale_qty > 0  -- 실제 판매가 발생한 날짜만 고려
  GROUP BY D.sty_cd, D.col_cd, D.size_cd
),

-- 최근 7일 기준 판매량
daily_sales_7d AS 
(
  SELECT
    D.sty_cd,
    D.col_cd,
    D.size_cd,
    toFloat64(sum(D.sale_qty)) AS total_7d_sale_qty,
    -- 일평균 계산 (판매 일수가 없으면 0으로 처리)
    CASE 
      WHEN SD7.sales_days_count_7d IS NOT NULL 
      THEN toFloat64(sum(D.sale_qty)) / SD7.sales_days_count_7d 
      ELSE toFloat64(0)
    END AS avg_daily_sales_d7,
    -- 주평균 계산 (7일 판매량을 그대로 주평균으로 처리)
    toFloat64(sum(D.sale_qty)) AS avg_weekly_sales_d7,
    SD7.first_sale_date_7d,
    SD7.last_sale_date_7d,
    SD7.sales_days_count_7d,
    SD7.sales_weeks_count_7d
  FROM daily_data_by_size D
  LEFT JOIN sales_days_7d SD7 ON 
    D.sty_cd = SD7.sty_cd AND 
    D.col_cd = SD7.col_cd AND 
    D.size_cd = SD7.size_cd
  WHERE D.br_cd = '{{ var_brand_code.value }}'
    AND D.sale_dt >= addDays(today(), -8)
    AND D.sale_dt < today()  -- 어제까지
  GROUP BY 
    D.sty_cd, 
    D.col_cd, 
    D.size_cd, 
    SD7.sales_days_count_7d,
    SD7.sales_weeks_count_7d,
    SD7.first_sale_date_7d,
    SD7.last_sale_date_7d
),


-- 11. 컬러별 합계 정보 (매장재고와 창고재고 추가)
color_totals AS 
(
  SELECT
    sty_cd,
    col_cd,
    toFloat64(sum(tot_in_qty)) AS color_tot_in_qty,
    toFloat64(sum(tot_sale_qty)) AS color_tot_sale_qty,
    toFloat64(sum(current_stock_qty)) AS color_current_stock,
    toFloat64(sum(wh_stck_qty)) AS color_wh_stck_qty,   -- 컬러별 창고재고 합계
    toFloat64(sum(sh_stck_qty)) AS color_sh_stck_qty    -- 컬러별 매장재고 합계
  FROM stock_info
  GROUP BY sty_cd, col_cd
),


-- 여기에 월별 판매량 CTE들을 추가 (shop_count_data 바로 다음)
monthly_sales AS (
  SELECT
    sty_cd,
    col_cd,
    size_cd,
    toStartOfMonth(sale_dt) AS month_start,
    toFloat64(sum(sale_qty)) AS monthly_sale_qty
  FROM daily_data_by_size
  WHERE sale_dt >= addMonths(toStartOfMonth(today()), -12)  -- 최근 12개월
    AND sale_dt < today()  -- 어제까지
  GROUP BY sty_cd, col_cd, size_cd, toStartOfMonth(sale_dt)
),

month_1_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(monthly_sale_qty)) AS month_1_sale_qty
  FROM monthly_sales
  WHERE month_start = toStartOfMonth(addMonths(today(), 0))  -- 이번 달
  GROUP BY sty_cd, col_cd, size_cd
),

month_2_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(monthly_sale_qty)) AS month_2_sale_qty
  FROM monthly_sales
  WHERE month_start = toStartOfMonth(addMonths(today(), -1))  -- 1개월 전
  GROUP BY sty_cd, col_cd, size_cd
),

month_3_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(monthly_sale_qty)) AS month_3_sale_qty
  FROM monthly_sales
  WHERE month_start = toStartOfMonth(addMonths(today(), -2))  -- 2개월 전
  GROUP BY sty_cd, col_cd, size_cd
),

month_4_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(monthly_sale_qty)) AS month_4_sale_qty
  FROM monthly_sales
  WHERE month_start = toStartOfMonth(addMonths(today(), -3))  -- 3개월 전
  GROUP BY sty_cd, col_cd, size_cd
),

month_5_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(monthly_sale_qty)) AS month_5_sale_qty
  FROM monthly_sales
  WHERE month_start = toStartOfMonth(addMonths(today(), -4))  -- 4개월 전
  GROUP BY sty_cd, col_cd, size_cd
),

month_6_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(monthly_sale_qty)) AS month_6_sale_qty
  FROM monthly_sales
  WHERE month_start = toStartOfMonth(addMonths(today(), -5))  -- 5개월 전
  GROUP BY sty_cd, col_cd, size_cd
),

month_7_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(monthly_sale_qty)) AS month_7_sale_qty
  FROM monthly_sales
  WHERE month_start = toStartOfMonth(addMonths(today(), -6))  -- 6개월 전
  GROUP BY sty_cd, col_cd, size_cd
),

month_8_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(monthly_sale_qty)) AS month_8_sale_qty
  FROM monthly_sales
  WHERE month_start = toStartOfMonth(addMonths(today(), -7))  -- 7개월 전
  GROUP BY sty_cd, col_cd, size_cd
),

month_9_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(monthly_sale_qty)) AS month_9_sale_qty
  FROM monthly_sales
  WHERE month_start = toStartOfMonth(addMonths(today(), -8))  -- 8개월 전
  GROUP BY sty_cd, col_cd, size_cd
),

month_10_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(monthly_sale_qty)) AS month_10_sale_qty
  FROM monthly_sales
  WHERE month_start = toStartOfMonth(addMonths(today(), -9))  -- 9개월 전
  GROUP BY sty_cd, col_cd, size_cd
),

month_11_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(monthly_sale_qty)) AS month_11_sale_qty
  FROM monthly_sales
  WHERE month_start = toStartOfMonth(addMonths(today(), -10))  -- 10개월 전
  GROUP BY sty_cd, col_cd, size_cd
),

month_12_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(monthly_sale_qty)) AS month_12_sale_qty
  FROM monthly_sales
  WHERE month_start = toStartOfMonth(addMonths(today(), -11))  -- 11개월 전
  GROUP BY sty_cd, col_cd, size_cd
),

-- 주간 판매량 CTE
weekly_sales AS (
  SELECT
    sty_cd,
    col_cd,
    size_cd,
    toStartOfWeek(sale_dt, 1) AS week_start, -- 주의 시작일을 월요일로 설정
    toFloat64(sum(sale_qty)) AS weekly_sale_qty
  FROM daily_data_by_size
  WHERE sale_dt >= addWeeks(toStartOfWeek(today(), 1), -12)  -- 최근 12주
    AND sale_dt < today()  -- 어제까지
  GROUP BY sty_cd, col_cd, size_cd, toStartOfWeek(sale_dt, 1)
),

week_1_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(weekly_sale_qty)) AS week_1_sale_qty
  FROM weekly_sales
  WHERE 
    week_start = toStartOfWeek(
      CASE 
        WHEN toDayOfWeek(today()) = 1 THEN addDays(today(), -7) -- 월요일일 경우 지난주(예: 2025-05-19)
        ELSE today() -- 그 외 현재 주(예: 2025-05-26)
      END, 
      1
    )
  GROUP BY sty_cd, col_cd, size_cd
),

week_2_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(weekly_sale_qty)) AS week_2_sale_qty
  FROM weekly_sales
  WHERE week_start = addWeeks(
    toStartOfWeek(
      CASE 
        WHEN toDayOfWeek(today()) = 1 THEN addDays(today(), -7)
        ELSE today()
      END, 
      1
    ), -1)  -- week_1_sales의 1주 전
  GROUP BY sty_cd, col_cd, size_cd
),

week_3_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(weekly_sale_qty)) AS week_3_sale_qty
  FROM weekly_sales
  WHERE week_start = addWeeks(
    toStartOfWeek(
      CASE 
        WHEN toDayOfWeek(today()) = 1 THEN addDays(today(), -7)
        ELSE today()
      END, 
      1
    ), -2)  -- week_1_sales의 2주 전
  GROUP BY sty_cd, col_cd, size_cd
),

week_4_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(weekly_sale_qty)) AS week_4_sale_qty
  FROM weekly_sales
  WHERE week_start = addWeeks(
    toStartOfWeek(
      CASE 
        WHEN toDayOfWeek(today()) = 1 THEN addDays(today(), -7)
        ELSE today()
      END, 
      1
    ), -3)  -- week_1_sales의 3주 전
  GROUP BY sty_cd, col_cd, size_cd
),

week_5_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(weekly_sale_qty)) AS week_5_sale_qty
  FROM weekly_sales
  WHERE week_start = addWeeks(
    toStartOfWeek(
      CASE 
        WHEN toDayOfWeek(today()) = 1 THEN addDays(today(), -7)
        ELSE today()
      END, 
      1
    ), -4)  -- week_1_sales의 4주 전
  GROUP BY sty_cd, col_cd, size_cd
),

week_6_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(weekly_sale_qty)) AS week_6_sale_qty
  FROM weekly_sales
  WHERE week_start = addWeeks(
    toStartOfWeek(
      CASE 
        WHEN toDayOfWeek(today()) = 1 THEN addDays(today(), -7)
        ELSE today()
      END, 
      1
    ), -5)  -- week_1_sales의 5주 전
  GROUP BY sty_cd, col_cd, size_cd
),

week_7_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(weekly_sale_qty)) AS week_7_sale_qty
  FROM weekly_sales
  WHERE week_start = addWeeks(
    toStartOfWeek(
      CASE 
        WHEN toDayOfWeek(today()) = 1 THEN addDays(today(), -7)
        ELSE today()
      END, 
      1
    ), -6)  -- week_1_sales의 6주 전
  GROUP BY sty_cd, col_cd, size_cd
),

week_8_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(weekly_sale_qty)) AS week_8_sale_qty
  FROM weekly_sales
  WHERE week_start = addWeeks(
    toStartOfWeek(
      CASE 
        WHEN toDayOfWeek(today()) = 1 THEN addDays(today(), -7)
        ELSE today()
      END, 
      1
    ), -7)  -- week_1_sales의 7주 전
  GROUP BY sty_cd, col_cd, size_cd
),

week_9_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(weekly_sale_qty)) AS week_9_sale_qty
  FROM weekly_sales
  WHERE week_start = addWeeks(
    toStartOfWeek(
      CASE 
        WHEN toDayOfWeek(today()) = 1 THEN addDays(today(), -7)
        ELSE today()
      END, 
      1
    ), -8)  -- week_1_sales의 8주 전
  GROUP BY sty_cd, col_cd, size_cd
),

week_10_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(weekly_sale_qty)) AS week_10_sale_qty
  FROM weekly_sales
  WHERE week_start = addWeeks(
    toStartOfWeek(
      CASE 
        WHEN toDayOfWeek(today()) = 1 THEN addDays(today(), -7)
        ELSE today()
      END, 
      1
    ), -9)  -- week_1_sales의 9주 전
  GROUP BY sty_cd, col_cd, size_cd
),

week_11_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(weekly_sale_qty)) AS week_11_sale_qty
  FROM weekly_sales
  WHERE week_start = addWeeks(
    toStartOfWeek(
      CASE 
        WHEN toDayOfWeek(today()) = 1 THEN addDays(today(), -7)
        ELSE today()
      END, 
      1
    ), -10)  -- week_1_sales의 10주 전
  GROUP BY sty_cd, col_cd, size_cd
),

week_12_sales AS (
  SELECT
    sty_cd, col_cd, size_cd,
    toFloat64(sum(weekly_sale_qty)) AS week_12_sale_qty
  FROM weekly_sales
  WHERE week_start = addWeeks(
    toStartOfWeek(
      CASE 
        WHEN toDayOfWeek(today()) = 1 THEN addDays(today(), -7)
        ELSE today()
      END, 
      1
    ), -11)  -- week_1_sales의 11주 전
  GROUP BY sty_cd, col_cd, size_cd
),

-- 리오더 계산을 위한 상수값 정의는 필요한 원본 데이터이므로 유지
reorder_constants AS (
  SELECT 
    toFloat64(60) AS lead_time_days,
    toFloat64(1) AS target_sale_rate,
    toFloat64(1000) AS moq,
    toFloat64(3) AS expected_sales_period_months
)
      
SELECT
  -- 다른 모든 필드는 유지하되 item_image 관련 필드 제거
  B.sty_cd AS sty_cd,
  B.sty_nm AS sty_nm,
  B.col_cd AS col_cd,
  B.col_nm AS col_nm,
  B.size_cd AS size_cd,
  B.size_nm AS size_nm,
  B.series_name AS series_name,
  B.tag_price AS tag_price,
  B.cost_price AS cost_price,
  B.large_cat AS large_cat,
  B.middle_cat AS middle_cat,
  B.small_cat AS small_cat,
  B.it AS it,
  B.it_nm AS it_nm,
  B.it_gb AS it_gb,
  B.it_gb_nm AS it_gb_nm,
  B.item AS item,
  B.item_nm AS item_nm,
  B.first_sales_dt AS first_sales_dt,
  B.cust_cd AS cust_cd,
  B.cust_nm AS cust_nm,
  B.br_nm AS br_nm,
  B.fabric AS fabric,
  
  -- 재고 정보와 기타 모든 필드 유지
  SI.tot_in_qty AS tot_in_qty,
  SI.tot_sale_qty AS tot_sale_qty,
  SI.current_stock_qty AS current_stock_qty,
  SI.wh_stck_qty AS wh_stck_qty,
  SI.sh_stck_qty AS sh_stck_qty,
  
  COALESCE(OQI.tot_out_qty, toFloat64(0)) AS tot_out_qty,
  COALESCE(COT.color_tot_out_qty, toFloat64(0)) AS color_tot_out_qty,
  
  CT.color_tot_in_qty AS color_tot_in_qty,
  CT.color_tot_sale_qty AS color_tot_sale_qty,
  CT.color_current_stock AS color_current_stock,
  CT.color_wh_stck_qty AS color_wh_stck_qty,
  CT.color_sh_stck_qty AS color_sh_stck_qty,
  
  ID.first_inventory_date AS first_inventory_date,
  ID.last_inventory_date AS last_inventory_date,
  FOD.first_outbound_date AS first_outbound_date,
  
  COALESCE(ATS.total_all_time_sale_qty, toFloat64(0)) AS total_all_time_sale_qty,
  COALESCE(ATS.avg_daily_sales, toFloat64(0)) AS avg_daily_sales,
  COALESCE(ATS.avg_monthly_sales, toFloat64(0)) AS avg_monthly_sales,
  COALESCE(ATS.total_sales_days, toFloat64(0)) AS total_sales_days,
  COALESCE(ATS.total_sales_months, toFloat64(0)) AS total_sales_months,
  ATS.first_sale_date_all AS first_sale_date_all,
  ATS.last_sale_date_all AS last_sale_date_all,
  
  COALESCE(DS7.avg_daily_sales_d7, toFloat64(0)) AS avg_daily_sales_d7,
  COALESCE(DS30.total_30d_sale_qty, toFloat64(0)) AS sales_qty_30d,
  COALESCE(DS30.avg_daily_sales_d30, toFloat64(0)) AS avg_daily_sales_d30,
  COALESCE(DS30.avg_monthly_sales_d30, toFloat64(0)) AS avg_monthly_sales_d30,
  COALESCE(DS30.sales_days_count_30d, toFloat64(0)) AS sales_days_count_30d,
  COALESCE(DS30.sales_months_count_30d, toFloat64(0)) AS sales_months_count_30d,
  DS30.first_sale_date_30d AS first_sale_date_30d,
  DS30.last_sale_date_30d AS last_sale_date_30d,
  
  COALESCE(DS180.total_180d_sale_qty, toFloat64(0)) AS sales_qty_180d,
  COALESCE(DS180.avg_daily_sales_d180, toFloat64(0)) AS avg_daily_sales_d180,
  COALESCE(DS180.avg_monthly_sales_d180, toFloat64(0)) AS avg_monthly_sales_d180,
  COALESCE(DS180.sales_days_count_180d, toFloat64(0)) AS sales_days_count_180d,
  COALESCE(DS180.sales_months_count_180d, toFloat64(0)) AS sales_months_count_180d,
  DS180.first_sale_date_180d AS first_sale_date_180d,
  DS180.last_sale_date_180d AS last_sale_date_180d,
  
  COALESCE(DS365.total_365d_sale_qty, toFloat64(0)) AS sales_qty_365d,
  COALESCE(DS365.avg_daily_sales_d365, toFloat64(0)) AS avg_daily_sales_d365,
  COALESCE(DS365.avg_monthly_sales_d365, toFloat64(0)) AS avg_monthly_sales_d365,
  COALESCE(DS365.sales_days_count_365d, toFloat64(0)) AS sales_days_count_365d,
  COALESCE(DS365.sales_months_count_365d, toFloat64(0)) AS sales_months_count_365d,
  DS365.first_sale_date_365d AS first_sale_date_365d,
  DS365.last_sale_date_365d AS last_sale_date_365d,
  
  CASE WHEN SI.tot_in_qty > 0 THEN SI.tot_sale_qty / SI.tot_in_qty ELSE toFloat64(0) END AS sale_rate,
  
  COALESCE(M1.month_1_sale_qty, toFloat64(0)) AS month_1_sale_qty,
  COALESCE(M2.month_2_sale_qty, toFloat64(0)) AS month_2_sale_qty,
  COALESCE(M3.month_3_sale_qty, toFloat64(0)) AS month_3_sale_qty,
  COALESCE(M4.month_4_sale_qty, toFloat64(0)) AS month_4_sale_qty,
  COALESCE(M5.month_5_sale_qty, toFloat64(0)) AS month_5_sale_qty,
  COALESCE(M6.month_6_sale_qty, toFloat64(0)) AS month_6_sale_qty,
  COALESCE(M7.month_7_sale_qty, toFloat64(0)) AS month_7_sale_qty,
  COALESCE(M8.month_8_sale_qty, toFloat64(0)) AS month_8_sale_qty,
  COALESCE(M9.month_9_sale_qty, toFloat64(0)) AS month_9_sale_qty,
  COALESCE(M10.month_10_sale_qty, toFloat64(0)) AS month_10_sale_qty,
  COALESCE(M11.month_11_sale_qty, toFloat64(0)) AS month_11_sale_qty,
  COALESCE(M12.month_12_sale_qty, toFloat64(0)) AS month_12_sale_qty,

  -- 주간 판매량 추가
  COALESCE(W1.week_1_sale_qty, toFloat64(0)) AS week_1_sale_qty,
  COALESCE(W2.week_2_sale_qty, toFloat64(0)) AS week_2_sale_qty,
  COALESCE(W3.week_3_sale_qty, toFloat64(0)) AS week_3_sale_qty,
  COALESCE(W4.week_4_sale_qty, toFloat64(0)) AS week_4_sale_qty,
  COALESCE(W5.week_5_sale_qty, toFloat64(0)) AS week_5_sale_qty,
  COALESCE(W6.week_6_sale_qty, toFloat64(0)) AS week_6_sale_qty,
  COALESCE(W7.week_7_sale_qty, toFloat64(0)) AS week_7_sale_qty,
  COALESCE(W8.week_8_sale_qty, toFloat64(0)) AS week_8_sale_qty,
  COALESCE(W9.week_9_sale_qty, toFloat64(0)) AS week_9_sale_qty,
  COALESCE(W10.week_10_sale_qty, toFloat64(0)) AS week_10_sale_qty,
  COALESCE(W11.week_11_sale_qty, toFloat64(0)) AS week_11_sale_qty,
  COALESCE(W12.week_12_sale_qty, toFloat64(0)) AS week_12_sale_qty,

  (SELECT active_shop_count FROM shop_count_data) AS active_shop_count,
  
  (SELECT lead_time_days FROM reorder_constants) AS lead_time_days,
  (SELECT target_sale_rate FROM reorder_constants) AS target_sale_rate,
  (SELECT moq FROM reorder_constants) AS moq,
  (SELECT expected_sales_period_months FROM reorder_constants) AS expected_sales_period_months

FROM base_products B
LEFT JOIN stock_info SI ON B.sty_cd = SI.sty_cd AND B.col_cd = SI.col_cd AND B.size_cd = SI.size_cd
LEFT JOIN color_totals CT ON B.sty_cd = CT.sty_cd AND B.col_cd = CT.col_cd
LEFT JOIN inventory_dates ID ON B.sty_cd = ID.sty_cd AND B.col_cd = ID.col_cd AND B.size_cd = ID.size_cd
LEFT JOIN first_outbound_dates FOD ON B.sty_cd = FOD.sty_cd AND B.col_cd = FOD.col_cd AND B.size_cd = FOD.size_cd
LEFT JOIN all_time_sales ATS ON B.sty_cd = ATS.sty_cd AND B.col_cd = ATS.col_cd AND B.size_cd = ATS.size_cd
LEFT JOIN daily_sales_7d DS7 ON B.sty_cd = DS7.sty_cd AND B.col_cd = DS7.col_cd AND B.size_cd = DS7.size_cd
LEFT JOIN daily_sales_30d DS30 ON B.sty_cd = DS30.sty_cd AND B.col_cd = DS30.col_cd AND B.size_cd = DS30.size_cd
LEFT JOIN daily_sales_180d DS180 ON B.sty_cd = DS180.sty_cd AND B.col_cd = DS180.col_cd AND B.size_cd = DS180.size_cd
LEFT JOIN daily_sales_365d DS365 ON B.sty_cd = DS365.sty_cd AND B.col_cd = DS365.col_cd AND B.size_cd = DS365.size_cd

LEFT JOIN outbound_qty_info OQI ON B.sty_cd = OQI.sty_cd AND B.col_cd = OQI.col_cd AND B.size_cd = OQI.size_cd
LEFT JOIN color_outbound_totals COT ON B.sty_cd = COT.sty_cd AND B.col_cd = COT.col_cd

-- 월별 판매량 JOIN
LEFT JOIN month_1_sales M1 ON B.sty_cd = M1.sty_cd AND B.col_cd = M1.col_cd AND B.size_cd = M1.size_cd
LEFT JOIN month_2_sales M2 ON B.sty_cd = M2.sty_cd AND B.col_cd = M2.col_cd AND B.size_cd = M2.size_cd
LEFT JOIN month_3_sales M3 ON B.sty_cd = M3.sty_cd AND B.col_cd = M3.col_cd AND B.size_cd = M3.size_cd
LEFT JOIN month_4_sales M4 ON B.sty_cd = M4.sty_cd AND B.col_cd = M4.col_cd AND B.size_cd = M4.size_cd
LEFT JOIN month_5_sales M5 ON B.sty_cd = M5.sty_cd AND B.col_cd = M5.col_cd AND B.size_cd = M5.size_cd
LEFT JOIN month_6_sales M6 ON B.sty_cd = M6.sty_cd AND B.col_cd = M6.col_cd AND B.size_cd = M6.size_cd
LEFT JOIN month_7_sales M7 ON B.sty_cd = M7.sty_cd AND B.col_cd = M7.col_cd AND B.size_cd = M7.size_cd
LEFT JOIN month_8_sales M8 ON B.sty_cd = M8.sty_cd AND B.col_cd = M8.col_cd AND B.size_cd = M8.size_cd
LEFT JOIN month_9_sales M9 ON B.sty_cd = M9.sty_cd AND B.col_cd = M9.col_cd AND B.size_cd = M9.size_cd
LEFT JOIN month_10_sales M10 ON B.sty_cd = M10.sty_cd AND B.col_cd = M10.col_cd AND B.size_cd = M10.size_cd
LEFT JOIN month_11_sales M11 ON B.sty_cd = M11.sty_cd AND B.col_cd = M11.col_cd AND B.size_cd = M11.size_cd
LEFT JOIN month_12_sales M12 ON B.sty_cd = M12.sty_cd AND B.col_cd = M12.col_cd AND B.size_cd = M12.size_cd

-- 주간 판매량 JOIN
LEFT JOIN week_1_sales W1 ON B.sty_cd = W1.sty_cd AND B.col_cd = W1.col_cd AND B.size_cd = W1.size_cd
LEFT JOIN week_2_sales W2 ON B.sty_cd = W2.sty_cd AND B.col_cd = W2.col_cd AND B.size_cd = W2.size_cd
LEFT JOIN week_3_sales W3 ON B.sty_cd = W3.sty_cd AND B.col_cd = W3.col_cd AND B.size_cd = W3.size_cd
LEFT JOIN week_4_sales W4 ON B.sty_cd = W4.sty_cd AND B.col_cd = W4.col_cd AND B.size_cd = W4.size_cd
LEFT JOIN week_5_sales W5 ON B.sty_cd = W5.sty_cd AND B.col_cd = W5.col_cd AND B.size_cd = W5.size_cd
LEFT JOIN week_6_sales W6 ON B.sty_cd = W6.sty_cd AND B.col_cd = W6.col_cd AND B.size_cd = W6.size_cd
LEFT JOIN week_7_sales W7 ON B.sty_cd = W7.sty_cd AND B.col_cd = W7.col_cd AND B.size_cd = W7.size_cd
LEFT JOIN week_8_sales W8 ON B.sty_cd = W8.sty_cd AND B.col_cd = W8.col_cd AND B.size_cd = W8.size_cd
LEFT JOIN week_9_sales W9 ON B.sty_cd = W9.sty_cd AND B.col_cd = W9.col_cd AND B.size_cd = W9.size_cd
LEFT JOIN week_10_sales W10 ON B.sty_cd = W10.sty_cd AND B.col_cd = W10.col_cd AND B.size_cd = W10.size_cd
LEFT JOIN week_11_sales W11 ON B.sty_cd = W11.sty_cd AND B.col_cd = W11.col_cd AND B.size_cd = W11.size_cd
LEFT JOIN week_12_sales W12 ON B.sty_cd = W12.sty_cd AND B.col_cd = W12.col_cd AND B.size_cd = W12.size_cd

WHERE SI.current_stock_qty >= 0  -- 현재고가 0 이하인 항목 제외