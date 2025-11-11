-- SELECT
-- case when parent_id is null then 55 else parent_id end as id,
-- max(br_cd),
-- case when parent_id is null then array['전체'] else array_agg(jsonb_array_elements_text(item_nm_list)) end as item_nm_list
-- FROM item_md_category
-- WHERE br_cd = '{{ var_brand_code.value }}'
-- GROUP BY parent_id
-- order by parent_id asc;

SELECT 
case when parent_id is null then 89 else parent_id end as id, 
max(br_cd),
case when parent_id is null then array['전체'] else array_agg(item_name) end AS item_nm_list
FROM (
    SELECT 
        parent_id, 
        jsonb_array_elements_text(item_nm_list) AS item_name,
        br_cd,
        category_depth
    FROM item_md_category
    WHERE br_cd = '{{ var_brand_code.value }}'
) AS expanded
GROUP BY parent_id
ORDER BY parent_id;


-- --select * from item_md_category where br_cd = '01' order by id asc
-- SELECT
-- parent_id as id,
-- max(br_cd),
-- array_agg(cat_nm) as cat_nm_list
-- FROM item_md_category
-- WHERE br_cd = '01' and parent_id is not null
-- GROUP BY parent_id
-- order by parent_id asc;