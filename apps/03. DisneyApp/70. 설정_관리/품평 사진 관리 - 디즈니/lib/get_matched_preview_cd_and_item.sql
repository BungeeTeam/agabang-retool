WITH folder_filter AS (
    SELECT
        splitByChar('_', '{{ sel_folder.value }}')[1] as folder_year,
        splitByChar('_', '{{ sel_folder.value }}')[2] as folder_season,
        splitByChar('_', '{{ sel_folder.value }}')[3] as folder_category
),
season_mapping AS (
    SELECT
        folder_year,
        folder_season,
        folder_category,
        char(ascii('S') + (toInt32(folder_year) - 25)) as year_cd_filter
    FROM folder_filter
),
-- 이하 코드는 동일
preview_mapping AS (
    SELECT 
        rim.sty_cd as sty_cd,
        rim.sty_nm as sty_nm,
        rim.preview_cd as preview_cd,
        rim.it_gb_cd as it_gb,
        splitByChar('/', COALESCE(rim.preview_cd, ''))[1] as preview_1,
        splitByChar('/', COALESCE(rim.preview_cd, ''))[2] as preview_2,
        splitByChar('/', COALESCE(rim.preview_cd, ''))[3] as preview_3,
        splitByChar('/', COALESCE(rim.preview_cd, ''))[4] as preview_4,
        splitByChar('/', COALESCE(rim.preview_cd, ''))[5] as preview_5,
        COALESCE(rim.color_1_nm, '') as color_1,
        COALESCE(rim.color_2_nm, '') as color_2,
        COALESCE(rim.color_3_nm, '') as color_3,
        COALESCE(rim.color_4_nm, '') as color_4,
        COALESCE(rim.color_5_nm, '') as color_5,
        COALESCE(rim.color_1_qty, 0) as qty_1,
        COALESCE(rim.color_2_qty, 0) as qty_2,
        COALESCE(rim.color_3_qty, 0) as qty_3,
        COALESCE(rim.color_4_qty, 0) as qty_4,
        COALESCE(rim.color_5_qty, 0) as qty_5,
        season_mapping.folder_category as folder_category
    FROM agabang_dw.retooldb_item_md_info rim
    CROSS JOIN season_mapping
    WHERE rim.br_cd = '{{ var_brand_code.value }}'
      AND rim.preview_cd IS NOT NULL
      AND rim.preview_cd != ''
      AND rim.year_cd = season_mapping.year_cd_filter
      AND (
        (season_mapping.folder_season = 'SP' AND rim.sesn_cd IN ('1', '2'))
        OR (season_mapping.folder_season = 'SM' AND rim.sesn_cd IN ('3', '4'))
        OR (season_mapping.folder_season = 'FA' AND rim.sesn_cd IN ('5', '6'))
        OR (season_mapping.folder_season = 'WT' AND rim.sesn_cd IN ('7', '8'))
        OR (season_mapping.folder_season = 'NO' AND rim.sesn_cd = '0')
      )
),
final_mapping AS (
    SELECT sty_cd, sty_nm, preview_1 as preview_cd, color_1 as col_nm, qty_1 as color_qty, it_gb
    FROM preview_mapping
    WHERE preview_1 != '' AND color_1 != ''
    
    UNION ALL
    
    SELECT sty_cd, sty_nm, preview_2 as preview_cd, color_2 as col_nm, qty_2 as color_qty, it_gb
    FROM preview_mapping
    WHERE preview_2 != '' AND color_2 != ''
    
    UNION ALL
    
    SELECT sty_cd, sty_nm, preview_3 as preview_cd, color_3 as col_nm, qty_3 as color_qty, it_gb
    FROM preview_mapping
    WHERE preview_3 != '' AND color_3 != ''
    
    UNION ALL
    
    SELECT sty_cd, sty_nm, preview_4 as preview_cd, color_4 as col_nm, qty_4 as color_qty, it_gb
    FROM preview_mapping
    WHERE preview_4 != '' AND color_4 != ''
    
    UNION ALL
    
    SELECT sty_cd, sty_nm, preview_5 as preview_cd, color_5 as col_nm, qty_5 as color_qty, it_gb
    FROM preview_mapping
    WHERE preview_5 != '' AND color_5 != ''
)
SELECT 
    preview_cd,
    sty_cd,
    sty_nm,
    col_nm,
    color_qty,
    it_gb
FROM final_mapping
ORDER BY preview_cd, sty_cd