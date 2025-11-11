UPDATE site_brand_item_scrap AS s
            SET
                year_season = subquery.year::text || subquery.season,
                category_id = subquery.category_id
            FROM (
                SELECT
                    A.id,
                    (
                        CASE
                            -- 알파벳 코드 처리 (V-Z -> 2020-2024년)
                            WHEN SUBSTRING(A.item_code, 2, 1) ~ '^[A-Z]$'
                            THEN ASCII(SUBSTRING(A.item_code, 2, 1)) - ASCII('V') + 20
                            -- 숫자 코드 처리 (2-9 -> 2025-2032년)
                            WHEN SUBSTRING(A.item_code, 2, 1) ~ '^[0-9]$'
                            THEN CAST(SUBSTRING(A.item_code, 2, 1) AS INTEGER) + 23
                            -- 기본값
                            ELSE 20
                        END
                    ) AS year,
                    CASE
                        WHEN SUBSTRING(A.item_code, 3, 1) IN ('1', 'A') THEN 'SP'
                        WHEN SUBSTRING(A.item_code, 3, 1) IN ('3', 'B') THEN 'SM'
                        WHEN SUBSTRING(A.item_code, 3, 1) IN ('5', 'C') THEN 'FA'
                        WHEN SUBSTRING(A.item_code, 3, 1) IN ('7', 'D') THEN 'WT'
                        ELSE 'NO'
                    END AS season,
                    COALESCE(B.id,  0) AS category_id
                FROM site_brand_item_scrap AS A
                LEFT OUTER JOIN site_brand_category_mapping AS B
                ON SUBSTRING(A.item_code, 4, 3) = ANY(
                    SELECT jsonb_array_elements_text(B.happyland_category)
                )
                WHERE A.site = 'happyland' AND (A.year_season IS NULL OR A.category_id IS NULL OR A.category_id = 0 OR A.year_season ~ '^20[0-9]{2}')
            ) AS subquery
            WHERE s.id = subquery.id