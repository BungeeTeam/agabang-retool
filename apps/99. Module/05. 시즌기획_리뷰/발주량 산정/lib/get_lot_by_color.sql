WITH
lotBycolor as (
    SELECT
    sty_cd,
    color_1_nm AS col_nm,
    color_1_qty AS lot
FROM
    agabang_dw.retooldb_item_md_info

UNION ALL

SELECT
    sty_cd,
    color_2_nm AS col_nm,
    color_2_qty AS lot
FROM
    agabang_dw.retooldb_item_md_info
WHERE
    color_2_nm IS NOT NULL

UNION ALL

SELECT
    sty_cd,
    color_3_nm AS col_nm,
    color_3_qty AS lot
FROM
    agabang_dw.retooldb_item_md_info
WHERE
    color_3_nm IS NOT NULL

UNION ALL

SELECT
    sty_cd,
    color_4_nm AS col_nm,
    color_4_qty AS lot
FROM
    agabang_dw.retooldb_item_md_info
WHERE
    color_4_nm IS NOT NULL
)

SELECT
    distinct A.br_cd as br_cd,
             A.sty_cd as sty_cd, A.sty_nm as sty_nm,
             A.col_cd as col_cd, A.col_nm as col_nm,
             CONCAT(A.sty_cd,A.col_cd) as sty_col_cd,
             B.lot as lot
FROM agabang_dw.dim_style as A
LEFT JOIN lotBycolor as B ON A.sty_cd = B.sty_cd and A.col_nm = B.col_nm
WHERE substring(sty_cd,1,2) = '{{var_brand_code.value }}'