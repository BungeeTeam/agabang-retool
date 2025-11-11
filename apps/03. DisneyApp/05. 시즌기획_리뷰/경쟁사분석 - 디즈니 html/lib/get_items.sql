WITH COMPETITOR_LAST_ITEM AS (
    select *
    from(
            select
                *,
                row_number() over (partition by site, brand, item_code order by scrap_day desc) as rn
            from agabang_dw.retooldb_site_brand_item_scrap
    ) as T
    where T.rn = 1
)
SELECT
  A.category_id,
  B.category_name,
  A.brand,
  arrayElement(JSONExtract(assumeNotNull(A.image_urls), 'Array(String)'), 1) AS image_url,
  A.item_name,
  A.item_code,
  A.item_link,
  A.origin_price,
  A.color,
  NULL as sale_per
FROM COMPETITOR_LAST_ITEM as A
JOIN agabang_dw.retooldb_site_brand_category_mapping as B
  ON A.category_id = B.id
WHERE A.year_season = '{{sel_season.value}}'
  and A.category_id in ({{sel_category.value}})
  and A.category_id >= 0  -- 미분류(0) 포함
UNION ALL
SELECT
  B.id AS category_id,
  B.category_name AS category_name,
  '디즈니' AS brand,
  concat('https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/', A.sty_cd, A.col_cd, '.jpg') AS image_url,
  A.sty_nm AS item_name,
  A.sty_cd AS item_code,
  '' AS item_link,
  A.tag_prce AS origin_price,
  A.col_nm AS color,
  CASE 
    WHEN A.tot_in_qty > 0 AND A.tot_sale_qty >= 0 THEN 
      round((A.tot_sale_qty / A.tot_in_qty) * 100, 2)
    ELSE 0
  END as sale_per
FROM agabang_dw.prod_sales_stock_by_color AS A
INNER JOIN
(
    SELECT
        id,
        category_name,
        arrayJoin(JSONExtract(coalesce(ettoi_category, '[]'), 'Array(String)')) AS category_element
    FROM agabang_dw.retooldb_site_brand_category_mapping
    WHERE id >= 0  -- 미분류(0) 포함
) AS B
  ON substring(A.sty_cd, 5, 3) = B.category_element
INNER JOIN agabang_dw.retooldb_code_season AS C
  ON substring(A.sty_cd, 3, 2) = C.year_sesn_cd
WHERE concat(C.year_nm_short, C.sesn_nm_eng) = '{{sel_season.value}}'
  AND A.br_cd = '79'
  AND B.id in ({{sel_category.value}})
ORDER BY 
  CASE 
    WHEN A.tot_in_qty > 0 AND A.tot_sale_qty >= 0 THEN 
      round((A.tot_sale_qty / A.tot_in_qty) * 100, 2)
    ELSE 0
  END desc