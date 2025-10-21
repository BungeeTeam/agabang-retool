WITH
    '07' as brand_code,
    /* 기준 날짜 설정 */
    toDate('{{base_day.value}}') AS reference_date,
    /* 어제 날짜 계산 */
    reference_date - INTERVAL 0 DAY AS yesterday,
    /* 일주일 종료 날짜 계산 */
    reference_date - INTERVAL 1 DAY AS one_week_ago_end,
    /* 일주일 시작 날짜 계산 */
    reference_date - INTERVAL 7 DAY AS one_week_ago,
SHOP_SEASON_SALES as (
    SELECT shop_nm,
         groupArray(
                 concat('{"year_sesn_nm_kor": "', year_sesn_nm_kor, '", "sale_qty": ',
                        toString(sales_qty), '}')
         ) as sales_info
    FROM (
           SELECT A.shop_nm        as shop_nm,
                  B.year_sesn_nm_kor,
                  sum(A.sales_qty) as sales_qty
           FROM day_shop_sty_sales as A
                    JOIN code_season as B
                         ON substring(A.sty_cd, 3, 2) = B.year_sesn_cd
           WHERE A.sale_dt = reference_date
             AND A.br_cd = brand_code
           GROUP BY 1, 2
           ORDER BY 1, 3 desc
    ) as T
    GROUP BY 1
)
              SELECT
                  T.shop_nm,
                  T.yesterday_sales_qty,
                  T.avg_week_sales_qty,
                  T.total_week_sales_qty,
                  T.stddev_week_sales_qty,
                  T.daily_sales_qty_array,
                  round((yesterday_sales_qty - avg_week_sales_qty)/avg_week_sales_qty, 2) as diff_per,
                  round((yesterday_sales_qty - avg_week_sales_qty) / stddev_week_sales_qty,2) as score,
                  SHOP_SEASON_SALES.sales_info as sales_info
            FROM (
                SELECT
                    A.shop_nm,      /* 매장 이름 */
                    sumIf(daily_sales_qty, sale_dt = yesterday) AS yesterday_sales_qty,  /* 어제(2024-09-03)의 판매량 */
                    sumIf(daily_sales_qty, sale_dt BETWEEN one_week_ago AND one_week_ago_end) AS total_week_sales_qty,  /* 최근 일주일간의 판매량 */
                    round(avgIf(daily_sales_qty, sale_dt BETWEEN one_week_ago AND one_week_ago_end)) AS avg_week_sales_qty,  /* 일주일간 평균 판매량 */
                    stddevPopIf(daily_sales_qty, sale_dt BETWEEN one_week_ago AND one_week_ago_end) AS stddev_week_sales_qty,  /* 일주일간 표준편차 */
                    arraySort(groupArray((sale_dt, daily_sales_qty))) AS daily_sales_qty_array  /* 일별 판매량을 배열로 반환 */
                FROM
                (
                    /* 날짜 범위 생성 및 판매 데이터와 결합하여 값이 없는 날은 0으로 처리 */
                    SELECT
                        dates.date AS sale_dt,
                        sales.shop_nm AS shop_nm,
                        if(sales.daily_sales_qty IS NULL, 0, sales.daily_sales_qty) AS daily_sales_qty  /* 값이 없는 날은 0으로 처리 */
                    FROM
                    (
                        /* 날짜 범위 생성 */
                        SELECT arrayJoin(arrayMap(x -> one_week_ago + x, range(0, 8))) AS date
                    ) AS dates
                    LEFT JOIN
                    (
                        /* 상품별로 일별 판매량 집계 */
                        SELECT
                            shop_nm,      /* 스타일 이름 */
                            sale_dt,     /* 날짜 */
                            sum(sales_qty) AS daily_sales_qty  /* 일별 판매량 집계 */
                        FROM
                            day_shop_sty_sales
                        WHERE sale_dt BETWEEN one_week_ago AND yesterday  /* 일주일 데이터를 필터링 */
                          AND br_cd = brand_code
                        GROUP BY
                            shop_nm, sale_dt  /* 매장별, 일별로 그룹화 */
                    ) AS sales
                    ON dates.date = sales.sale_dt AND sales.shop_nm IS NOT NULL /* 날짜 및 스타일 코드 기준으로 결합 */
                ) as A
                GROUP BY
                    A.shop_nm   /* 매장 이름 */
                HAVING
                    yesterday_sales_qty > avg_week_sales_qty  /* 어제 판매량이 평균 보다 크고 */
                    AND 
                    avg_week_sales_qty > {{min_week_sales_qty.value}}   /* 지난주 최소 판매량  */
                    AND yesterday_sales_qty >= {{min_sales_qty.value}}  /* 어제 판매량이 최소 10 이상인 경우 */
            ) as T
            JOIN SHOP_SEASON_SALES
              ON T.shop_nm = SHOP_SEASON_SALES.shop_nm
            ORDER BY
                (yesterday_sales_qty - avg_week_sales_qty) / stddev_week_sales_qty DESC