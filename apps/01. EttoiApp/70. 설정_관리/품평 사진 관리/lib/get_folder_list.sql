SELECT
  extracted_path,
  MAX(cnt) AS cnt
FROM (
  -- 첫 번째 쿼리: item_image_review 테이블에서 경로와 개수 추출
  SELECT
      regexp_replace(replace(s3_key, 'item_review/', ''), '/[^/]+$', '') AS extracted_path,
      count(*) AS cnt
  FROM item_image_review
  WHERE s3_key LIKE 'item_review/%' and s3_key not like '%brand_%'
  GROUP BY extracted_path
  
  UNION ALL
  
  -- 두 번째 쿼리: 내년 시즌 경로 생성
  SELECT 
      CONCAT(
          TO_CHAR(CURRENT_DATE + INTERVAL '1 year', 'YY'),
          season,
          ' 아이템사진/', 
          category, 
          ' PHOTO'
      ) AS extracted_path,
      0 AS cnt  -- 두 번째 쿼리에는 cnt 값을 0으로 설정
  FROM 
      (VALUES 
          ('''SS', '외의'), 
          ('''SS', '기초'), 
          ('''FW', '외의'), 
          ('''FW', '기초'),
          ('''NO', '외의'), -- 'NO' 시즌 추가
          ('''NO', '기초')  -- 'NO' 시즌 추가
      ) AS season_category(season, category)
) AS T 
GROUP BY T.extracted_path
ORDER BY extracted_path DESC;