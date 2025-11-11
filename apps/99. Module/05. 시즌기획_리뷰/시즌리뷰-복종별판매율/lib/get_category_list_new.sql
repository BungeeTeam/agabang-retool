SELECT 
case when parent_id is null then 55 else parent_id end as id, 
max(br_cd),
case when parent_id is null then array['전체'] else array_agg(item_name) end AS item_nm_list
FROM (
    SELECT 
        parent_id, 
        jsonb_array_elements_text(item_nm_list) AS item_name,
        br_cd,
        category_depth
    FROM item_md_category
    WHERE br_cd = '{{ brand_code.value }}'
) AS expanded
GROUP BY parent_id
ORDER BY parent_id;