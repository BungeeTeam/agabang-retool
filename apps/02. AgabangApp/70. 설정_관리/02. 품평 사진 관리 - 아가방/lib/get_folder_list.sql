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
          ('SS', '언더'),
          ('SP', '의류'),
          ('SM', '의류'),
          ('FW', '언더'),
          ('FA', '의류'),
          ('WT', '의류'),
          ('NO', '언더'),
          ('NO', '의류')
      ) AS season_category(season, category),
      (VALUES
          (CURRENT_DATE),
          (CURRENT_DATE + INTERVAL '1 year')
      ) AS years(year_date)
) AS T
GROUP BY T.extracted_path
ORDER BY 
  split_part(T.extracted_path, '_', 1) DESC,  -- 연도 내림차순
  CASE split_part(T.extracted_path, '_', 2)   -- 시즌 우선순위
    WHEN 'WT' THEN 1  -- 겨울 의류
    WHEN 'FA' THEN 2  -- 가을 의류
    WHEN 'FW' THEN 3  -- 가을+겨울 언더
    WHEN 'SM' THEN 4  -- 여름 의류
    WHEN 'SP' THEN 5  -- 봄 의류
    WHEN 'SS' THEN 6  -- 봄+여름 언더
    WHEN 'NO' THEN 7  -- 무시즌
    ELSE 8
  END,
  split_part(T.extracted_path, '_', 3)  -- 카테고리