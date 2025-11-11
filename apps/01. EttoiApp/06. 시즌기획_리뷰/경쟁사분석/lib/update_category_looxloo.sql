UPDATE site_brand_item_scrap AS s
            SET
                year_season = subquery.year || subquery.season,
                category_id = subquery.category_id
            FROM (
                SELECT
                    A.id,
                    CASE 
                        WHEN SUBSTRING(A.item_code, 2, 1) ~ '^[0-9]$' 
                        THEN CAST(SUBSTRING(A.item_code, 2, 1) AS INTEGER) + 20 
                        ELSE 20 
                    END AS year,
                    CASE
                        WHEN SUBSTRING(A.item_code, 3, 1) IN ('1', '2') THEN 'SP'
                        WHEN SUBSTRING(A.item_code, 3, 1) IN ('3', '4') THEN 'SM'
                        WHEN SUBSTRING(A.item_code, 3, 1) IN ('A', 'B') THEN 'FA'
                        WHEN SUBSTRING(A.item_code, 3, 1) IN ('C', 'D') THEN 'WT'
                        ELSE 'NO'
                    END AS season,
                    COALESCE(B.id, 0) AS category_id
                FROM site_brand_item_scrap AS A
                LEFT OUTER JOIN site_brand_category_mapping AS B
                ON SUBSTRING(A.item_code, 6, 3) = ANY(
                    SELECT jsonb_array_elements_text(B.looxloo_category)
                )
                WHERE A.site = 'looxloo' AND (A.year_season IS NULL OR A.category_id IS NULL OR A.category_id = 0 OR A.year_season ~ '^20[0-9]{2}')
            ) AS subquery
            WHERE s.id = subquery.id