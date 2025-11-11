INSERT INTO item_image_review_by_brand (s3_key)
VALUES ('{{s3_upload.data.fileName.replace("'", "''")}}')
ON CONFLICT (s3_key)
DO UPDATE SET 
  created_time = now();