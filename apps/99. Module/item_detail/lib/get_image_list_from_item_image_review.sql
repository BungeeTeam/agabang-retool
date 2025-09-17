SELECT
    *
FROM item_image_review
WHERE s3_key like 'item_upload/{{ sel_folder.value.replace("'", "''") }}%'
AND (
  ({{search_text.value.length}} = 0)
  OR 
  ({{search_text.value.length}} > 0
  AND s3_key like '%{{ search_text.value}}%')
)
ORDER BY s3_key