SELECT
  split_part(extracted_path, '_', 1)
  || ''''
  || split_part(extracted_path, '_', 2)
  || ' 아이템사진/'
  || split_part(extracted_path, '_', 3)
  || ' PHOTOS' as human_readable_path,
  extracted_path,
  MAX(cnt) AS cnt
FROM (
  SELECT
    split_part(s3_key, '/', -2) as extracted_path,
    count(*) AS cnt
  FROM item_image_review_by_brand
  WHERE s3_key LIKE 'item_review/brand_code={{var_brand_code.value}}/%'
  GROUP BY extracted_path

  UNION ALL

  -- Second query: Generate current and next year's season paths
  SELECT
    concat_ws('_',
      TO_CHAR(year_date, 'YY'),
      season,
      category
    ) AS extracted_path,
    0 AS cnt
  FROM
    (VALUES
      ('SP', '의류-언더'),
      ('SM', '의류-언더'),
      ('FA', '의류-언더'),
      ('WT', '의류-언더'),
      ('NO', '의류-언더-용품')
    ) AS season_category(season, category),
    (VALUES
      (CURRENT_DATE),
      (CURRENT_DATE + INTERVAL '1 year')
    ) AS years(year_date)
) AS T
GROUP BY T.extracted_path
ORDER BY
    -- 1. 연도를 기준으로 내림차순 정렬
    split_part(T.extracted_path, '_', 1) DESC,
    -- 2. 시즌 코드를 기준으로 커스텀 순서로 정렬
    CASE split_part(T.extracted_path, '_', 2)
        WHEN 'WT' THEN 1 -- 겨울
        WHEN 'FA' THEN 2 -- 가을
        WHEN 'SM' THEN 3 -- 여름
        WHEN 'SP' THEN 4 -- 봄
        WHEN 'NO' THEN 5 -- 무시즌
        ELSE 99
    END;