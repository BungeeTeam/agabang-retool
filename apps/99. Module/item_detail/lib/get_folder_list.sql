SELECT
  extracted_path,
  MAX(cnt) AS cnt
FROM (
  -- 첫 번째 쿼리: item_image_review 테이블에서 경로와 개수 추출
  SELECT
      CASE 
          -- s3_key에 'item_upload_test/' 이후 추가 슬래시가 있는지 확인
          WHEN s3_key ~ '^item_upload_test/[^/]+$' THEN 'item_upload'
          ELSE regexp_replace(replace(s3_key, 'item_upload/', ''), '/[^/]+$', '')
      END AS extracted_path,
      count(*) AS cnt
  FROM item_image_review
  WHERE s3_key LIKE 'item_upload/%'
  GROUP BY 
      CASE 
          WHEN s3_key ~ '^item_upload_test/[^/]+$' THEN 'item_upload'
          ELSE regexp_replace(replace(s3_key, 'item_upload/', ''), '/[^/]+$', '')
      END
) AS T 
GROUP BY T.extracted_path
ORDER BY extracted_path DESC;