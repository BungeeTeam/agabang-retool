DELETE FROM item_image_review 
WHERE s3_key = '{{sel_s3_key.value.replace("'", "''")}}'
