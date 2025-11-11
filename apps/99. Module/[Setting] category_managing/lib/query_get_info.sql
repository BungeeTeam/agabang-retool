WITH
    large_cat as (
        SELECT
            *
        FROM item_md_category
        WHERE br_cd = '{{ brand_code.value}}' and category_depth = 1
    )

SELECT
B.id as id,
A.br_cd as br_cd,
B.cat_nm as large_cat,
A.cat_nm as middle_cat,
A.item_nm_list as small_list,
A.origin_cat_nm as origin_cat_nm,
A.item_code as item_code,
A.use_yn as use_yn
FROM item_md_category as A
JOIN large_cat as B ON A.parent_id = B.id
WHERE  A.br_cd = '{{ brand_code.value}}'
ORDER BY A.item_code