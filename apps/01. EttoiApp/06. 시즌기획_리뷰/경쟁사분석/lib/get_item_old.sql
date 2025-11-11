SELECT *, json_build_array(site, brand) AS tags
FROM site_brand_item_scrap
WHERE brand = '{{ sel_brand.value }}'