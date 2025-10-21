WITH
                '07' AS brand_code,
                /* 기준 날짜 설정 */
                toDate('{{base_day.value}}') AS reference_date,
                /* 어제 날짜 계산 */
                reference_date - INTERVAL 0 DAY AS yesterday,
                /* 일주일 종료 날짜 계산 */
                reference_date - INTERVAL 1 DAY AS one_week_ago_end,
                /* 일주일 시작 날짜 계산 */
                reference_date - INTERVAL 7 DAY AS one_week_ago,
                /* 소진율 계산 */
                sty_tot_in_sale as (
                    select
                        sty_cd,
                        sty_nm,
                        sum(tot_in_qty) as tot_in_qty,
                        sum(tot_sale_qty) as tot_sale_qty
                    from agabang_dw.prod_sales_stock_by_size
                    where br_cd=brand_code
                    group by 1,2
            )
            SELECT
                  T.cat_nm as cat_nm,
                  T.sty_cd as sty_cd,
                  T.sty_nm as sty_nm,
                  T.image_link as image_link,
                  T.yesterday_sales_qty as yesterday_sales_qty,
                  T.avg_week_sales_qty as avg_week_sales_qty,
                  T.daily_sales_qty_array,
                  T.stddev_week_sales_qty,
                  round((yesterday_sales_qty - avg_week_sales_qty)/avg_week_sales_qty, 2) as diff_per,
                  round((yesterday_sales_qty - avg_week_sales_qty) / stddev_week_sales_qty,2) as score,
                  B.tag_prce as tag_prce,
                  C.tot_sale_qty as tot_sale_qty,
                  C.tot_in_qty as tot_in_qty,
                  round(C.tot_sale_qty / C.tot_in_qty,2) as sale_per
            FROM (
                SELECT
                    coalesce(B.cat_nm, '분류없음') as cat_nm,      /* 카테고리 */
                    A.sty_cd,      /* 스타일 코드 */
                    A.sty_nm,      /* 스타일 이름 */
                    concat('https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/', A.sty_cd, '.jpg') as image_link, /* 이미지 */
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
                        sales.sty_cd AS sty_cd,
                        sales.sty_nm AS sty_nm,
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
                            sty_cd,      /* 스타일 코드 */
                            sty_nm,      /* 스타일 이름 */
                            sale_dt,     /* 날짜 */
                            sum(sales_qty) AS daily_sales_qty  /* 일별 판매량 집계 */
                        FROM
                            day_shop_sty_sales
                        WHERE
                            sale_dt BETWEEN one_week_ago AND yesterday  /* 일주일 데이터를 필터링 */
                            AND br_cd = brand_code
                        GROUP BY
                            sty_cd, sty_nm, sale_dt  /* 상품별, 일별로 그룹화 */
                    ) AS sales
                    ON dates.date = sales.sale_dt AND sales.sty_cd IS NOT NULL /* 날짜 및 스타일 코드 기준으로 결합 */
                ) as A
                LEFT JOIN (
                    select
                        sty_cd,
                        max(sty_nm) as sty_nm,
                        max(cat_nm) as cat_nm
                    from agabang_dw.retooldb_item_md_info
                    where br_cd = brand_code
                    group by 1
                ) as B
                ON A.sty_cd = B.sty_cd
                GROUP BY
                    B.cat_nm, A.sty_cd, A.sty_nm   /* 매장 이름 제외하고 스타일 코드와 이름, 카테고리로으로 그룹화 */
                HAVING
                    yesterday_sales_qty > avg_week_sales_qty  /* 어제 판매량이 평균 보다 크고 */
                    AND yesterday_sales_qty >= {{min_sales_qty.value}}  /* 어제 판매량이 최소 10 이상인 경우 */
            ) as T
            JOIN agabang.plstycd as B
              on T.sty_cd = B.sty_cd
            JOIN sty_tot_in_sale as C
              on T.sty_cd = C.sty_cd
            ORDER BY
                T.cat_nm, (yesterday_sales_qty - avg_week_sales_qty) / stddev_week_sales_qty DESC