UPDATE site_brand_item_scrap AS s
            SET
                year_season = subquery.year::text || subquery.season,
                category_id = subquery.category_id
            FROM (
                SELECT
                    id,
                    (
                        (base_year +
                        CASE
                            -- 계산된 연도가 현재보다 5년 이상 미래일 경우 (예: 21년에 '9' -> 29년), 10년을 빼서 보정 (-> 19년)
                            WHEN (base_year - EXTRACT(YEAR FROM NOW())) > 5 THEN -10
                            -- 계산된 연도가 현재보다 5년 이상 과거일 경우 (예: 29년에 '1' -> 21년), 10년을 더해서 보정 (-> 31년)
                            WHEN (EXTRACT(YEAR FROM NOW()) - base_year) > 5 THEN 10
                            ELSE 0
                        END
                    )) % 100 AS year,
                    CASE
                        WHEN SUBSTRING(item_code, 4, 1) = '1' THEN 'SP'
                        WHEN SUBSTRING(item_code, 4, 1) = '2' THEN 'SM'
                        WHEN SUBSTRING(item_code, 4, 1) = '3' THEN 'FA'
                        WHEN SUBSTRING(item_code, 4, 1) = '4' THEN 'WT'
                        WHEN SUBSTRING(item_code, 4, 1) = '0' THEN 'NO'
                        ELSE 'NO'
                    END AS season,
                    category_id
                FROM (
                    -- DB 현재 시간 기준으로, 상품코드의 연도 숫자를 이용해 현재 decade 기준의 연도를 먼저 계산
                    SELECT
                        A.id,
                        A.item_code,
                        (FLOOR(EXTRACT(YEAR FROM NOW()) / 10) * 10 + CAST(SUBSTRING(A.item_code, 3, 1) AS INTEGER)) as base_year,
                        B.id as category_id
                    FROM site_brand_item_scrap AS A
                    LEFT OUTER JOIN site_brand_category_mapping AS B
                        ON SUBSTRING(A.item_code, 5, 2) = ANY(
                            SELECT jsonb_array_elements_text(B.bebedepino_category)
                        )
                    WHERE A.site = 'bebedepino' AND (A.year_season IS NULL OR A.category_id IS NULL OR A.category_id = 0 OR A.year_season ~ '^20[0-9]{2}')
                ) AS sub_with_base
            ) AS subquery
            WHERE s.id = subquery.id