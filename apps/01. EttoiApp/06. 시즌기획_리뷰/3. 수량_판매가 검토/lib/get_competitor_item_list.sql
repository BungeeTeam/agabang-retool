WITH 
  '07' as brand_code,
COMPETITOR_LAST_ITEM AS (
    select *
    from(
            select
                *,
                row_number() over (partition by site, brand, item_code order by scrap_day desc) as rn
            from agabang_dw.retooldb_site_brand_item_scrap
            where br_cd = brand_code
    ) as T
    where T.rn = 1
)
SELECT
  A.year_season,
  B.category_name,
  A.brand,
  arrayElement(JSONExtract(assumeNotNull(A.image_urls), 'Array(String)'), 1) AS image_url,
  A.item_name,
  A.item_code,
  A.item_link,
  A.origin_price as item_price
FROM COMPETITOR_LAST_ITEM as A
JOIN agabang_dw.retooldb_site_brand_category_mapping as B
  ON A.category_id = B.id
WHERE 
  A.year_season IN ( {{ var_season_list.value?.map(item => `'${item}'`).join(", ") || "''" }} )
  {{ select_category_item.value && select_category_item.value.length > 0 ? 
    `AND B.category_name IN (${select_category_item.value.map(item => `'${item}'`).join(", ")})` : 
    '' }}
  AND ('{{ switch_competitor.value }}' == 'true')