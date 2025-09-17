INSERT INTO item_image_review (s3_key)
VALUES ({{s3_upload.data.fileName}})
ON CONFLICT (s3_key)
DO UPDATE SET 
  created_time = now();