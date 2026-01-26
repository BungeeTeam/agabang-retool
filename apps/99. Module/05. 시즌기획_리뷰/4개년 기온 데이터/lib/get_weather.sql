-- get_weather 쿼리 수정 내용
WITH BaseData AS (
    -- 필요한 원본 데이터 선택 및 기본 계산 수행
    SELECT
        date,
        region_code,
        daily_temp_max,
        daily_temp_min,
        daily_temp_avg,
        daily_rain_amount,
        daily_snow_amount,

        -- 날짜 차이 계산 (원본 쿼리와 동일)
        dateDiff('day', date, toDate('{{ dateRange_day.value.end }}')) as diff_day,

        -- 비교 연도 계산 (원본 날짜 기준 연도)
        toYear(date) as comparison_year,

        -- 투영된 날짜 계산 (원본 쿼리의 'day' 로직 -> projected_full_date 로 명명)
        CASE
            WHEN dateDiff('day', date, toDate('{{ dateRange_day.value.end }}'))
                 < dateDiff('day', toDate(addYears('{{ dateRange_day.value.start }}', 0)), toDate('{{ dateRange_day.value.end }}')) + 1
                THEN toDate(addYears(date, 0))
            WHEN dateDiff('day', date, toDate('{{ dateRange_day.value.end }}'))
                 < dateDiff('day', toDate(addYears('{{ dateRange_day.value.start }}', -1)), toDate('{{ dateRange_day.value.end }}')) + 1
                THEN toDate(addYears(date, 1))
            WHEN dateDiff('day', date, toDate('{{ dateRange_day.value.end }}'))
                 < dateDiff('day', toDate(addYears('{{ dateRange_day.value.start }}', -2)), toDate('{{ dateRange_day.value.end }}')) + 1
                THEN toDate(addYears(date, 2))
            WHEN dateDiff('day', date, toDate('{{ dateRange_day.value.end }}'))
                 < dateDiff('day', toDate(addYears('{{ dateRange_day.value.start }}', -3)), toDate('{{ dateRange_day.value.end }}')) + 1
                THEN toDate(addYears(date, 3))
            WHEN dateDiff('day', date, toDate('{{ dateRange_day.value.end }}'))
                 < dateDiff('day', toDate(addYears('{{ dateRange_day.value.start }}', -4)), toDate('{{ dateRange_day.value.end }}')) + 1
                THEN toDate(addYears(date, 4))
            WHEN dateDiff('day', date, toDate('{{ dateRange_day.value.end }}'))
                 < dateDiff('day', toDate(addYears('{{ dateRange_day.value.start }}', -5)), toDate('{{ dateRange_day.value.end }}')) + 1
                THEN toDate(addYears(date, 5))
            ELSE '1970-01-01'::date
        END as projected_full_date,

        -- ClickHouse 함수 toMonday() 사용하여 주의 시작일 계산 (주간 집계용)
        toMonday(date) as original_week_start,
        toMonday(
             CASE -- 위 projected_full_date 와 동일한 로직
                 WHEN dateDiff('day', date, toDate('{{ dateRange_day.value.end }}')) < dateDiff('day', toDate(addYears('{{ dateRange_day.value.start }}', 0)), toDate('{{ dateRange_day.value.end }}')) + 1 THEN toDate(addYears(date, 0))
                 WHEN dateDiff('day', date, toDate('{{ dateRange_day.value.end }}')) < dateDiff('day', toDate(addYears('{{ dateRange_day.value.start }}', -1)), toDate('{{ dateRange_day.value.end }}')) + 1 THEN toDate(addYears(date, 1))
                 WHEN dateDiff('day', date, toDate('{{ dateRange_day.value.end }}')) < dateDiff('day', toDate(addYears('{{ dateRange_day.value.start }}', -2)), toDate('{{ dateRange_day.value.end }}')) + 1 THEN toDate(addYears(date, 2))
                 WHEN dateDiff('day', date, toDate('{{ dateRange_day.value.end }}')) < dateDiff('day', toDate(addYears('{{ dateRange_day.value.start }}', -3)), toDate('{{ dateRange_day.value.end }}')) + 1 THEN toDate(addYears(date, 3))
                 WHEN dateDiff('day', date, toDate('{{ dateRange_day.value.end }}')) < dateDiff('day', toDate(addYears('{{ dateRange_day.value.start }}', -4)), toDate('{{ dateRange_day.value.end }}')) + 1 THEN toDate(addYears(date, 4))
                 WHEN dateDiff('day', date, toDate('{{ dateRange_day.value.end }}')) < dateDiff('day', toDate(addYears('{{ dateRange_day.value.start }}', -5)), toDate('{{ dateRange_day.value.end }}')) + 1 THEN toDate(addYears(date, 5))
                 ELSE '1970-01-01'::date
             END
        ) as projected_week_start

    FROM retooldb_weather_data -- 테이블 이름 확인 필요
    WHERE
        -- 원본 쿼리의 WHERE 절 (기간 필터링)
        (
            (toDate(date) >= toDate(addYears(toDate('{{ dateRange_day.value.start }}'), -3)) AND toDate(date) <= toDate(addYears(toDate('{{ dateRange_day.value.end }}'), -3))) OR
            (toDate(date) >= toDate(addYears(toDate('{{ dateRange_day.value.start }}'), -2)) AND toDate(date) <= toDate(addYears(toDate('{{ dateRange_day.value.end }}'), -2))) OR
            (toDate(date) >= toDate(addYears(toDate('{{ dateRange_day.value.start }}'), -1)) AND toDate(date) <= toDate(addYears(toDate('{{ dateRange_day.value.end }}'), -1))) OR
            (toDate(date) >= toDate(addYears(toDate('{{ dateRange_day.value.start }}'), 0)) AND toDate(date) <= toDate(addYears(toDate('{{ dateRange_day.value.end }}'), 0)))
        )
        AND toDate(date) >= toDate(addYears(toDate('{{ dateRange_day.value.start }}'), -3))
        AND region_code = '{{ select_region.value }}' -- 지역 필터링
)
-- select_period 값에 따라 일간 또는 주간 집계 수행
SELECT
    'day' as period_granularity,           -- 기간 단위: 'day'
    diff_day as diff_from_end,          -- 일수 차이
    comparison_year,                    -- 비교 연도
    projected_full_date as period_start,-- 기간 시작 (일간: 투영된 날짜)
    date as original_period_start,      -- 원본 기간 시작 (일간: 원본 날짜)
    max(daily_temp_max) as temp_max,    -- 최고 온도 (원본 쿼리처럼 max)
    min(daily_temp_min) as temp_min,    -- 최저 온도 (원본 쿼리처럼 min)
    avg(daily_temp_avg) as temp_avg,    -- 평균 온도 (원본 쿼리처럼 avg)
    max(daily_rain_amount) as rain_amount, -- 강수량 (원본 쿼리처럼 max)
    max(daily_snow_amount) as snow_amount  -- 적설량 (원본 쿼리처럼 max)
FROM BaseData
WHERE '{{ select_period.value }}' = 'day' -- '일간' 선택 시 실행
GROUP BY
    period_granularity, diff_from_end, comparison_year, period_start, original_period_start -- 일별 그룹핑

UNION ALL

SELECT
    'week' as period_granularity,         -- 기간 단위: 'week'
    min(diff_day) as diff_from_end,     -- 주간 최소 일수 차이
    comparison_year,                    -- 비교 연도
    projected_week_start as period_start, -- 기간 시작 (주간: 투영된 주 시작일)
    original_week_start as original_period_start, -- 원본 기간 시작 (주간: 원본 주 시작일)
    max(daily_temp_max) as temp_max,    -- 주간 최고 온도
    min(daily_temp_min) as temp_min,    -- 주간 최저 온도
    avg(daily_temp_avg) as temp_avg,    -- 주간 평균 온도
    sum(daily_rain_amount) as rain_amount, -- **주간 총 강수량 (sum 사용)**
    sum(daily_snow_amount) as snow_amount  -- **주간 총 적설량 (sum 사용)**
FROM BaseData
WHERE '{{ select_period.value }}' = 'week' -- '주간' 선택 시 실행
GROUP BY
    period_granularity, comparison_year, period_start, original_period_start -- 주별 그룹핑

ORDER BY
    comparison_year, period_start -- 연도, 기간 시작일 순 정렬