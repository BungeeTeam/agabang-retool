select
  A.year_season,
  B.category_name,
  A.memo
from site_brand_category_memo as A 
join site_brand_category_mapping as B
on A.category_id = B.id 