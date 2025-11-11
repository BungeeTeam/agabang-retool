WITH folder_parsed AS (
    SELECT
        substring('{{ sel_folder.value.replace(/'/g, "") }}', 1, 2) as folder_year,
        substring('{{ sel_folder.value.replace(/'/g, "") }}', 3, 2) as folder_season
),
season_mapping AS (
    SELECT
        folder_year,
        folder_season,
        -- ## 변경된 부분 ##
        -- char(ascii(...)) 대신 substring을 사용하여 동적으로 연도 코드를 계산합니다.
        substring('KLMNOPQRSTUVWXYZ', toInt32(folder_year) - 17 + 1, 1) as year_cd_filter
    FROM folder_parsed
),
preview_mapping AS (
    SELECT
        sty_cd,
        sty_nm,
        preview_cd,
        splitByChar('/', COALESCE(preview_cd, '')) as preview_array,
        [
            COALESCE(color_1_nm, ''),
            COALESCE(color_2_nm, ''),
            COALESCE(color_3_nm, ''),
            COALESCE(color_4_nm, ''),
            COALESCE(color_5_nm, '')
        ] as color_nm_array,
        [
            COALESCE(color_1_qty, 0),
            COALESCE(color_2_qty, 0),
            COALESCE(color_3_qty, 0),
            COALESCE(color_4_qty, 0),
            COALESCE(color_5_qty, 0)
        ] as color_qty_array
    FROM agabang_dw.retooldb_item_md_info, season_mapping
    WHERE br_cd = '{{ var_brand_code.value }}'
      AND preview_cd IS NOT NULL
      AND preview_cd != ''
      AND year_cd = season_mapping.year_cd_filter
      AND (
          (season_mapping.folder_season = 'SS' AND sesn_cd IN ('1', '3')) OR
          (season_mapping.folder_season = 'FW' AND sesn_cd IN ('5', '7')) OR
          (season_mapping.folder_season = 'NO' AND sesn_cd = '0')
      )
),
preview_color_mapping AS (
    SELECT
        sty_cd,
        sty_nm,
        preview_cd,
        arrayJoin(
            arrayZip(
                preview_array,
                arraySlice(color_nm_array, 1, length(preview_array)),
                arraySlice(color_qty_array, 1, length(preview_array))
            )
        ) as mapping
    FROM preview_mapping
),
final_mapping AS (
    SELECT
        sty_cd,
        sty_nm,
        mapping.1 as individual_preview_cd,
        mapping.2 as color_nm,
        mapping.3 as color_qty
    FROM preview_color_mapping
    WHERE mapping.2 != ''
)
SELECT DISTINCT
    fm.individual_preview_cd as preview_cd,
    fm.sty_cd,
    fm.sty_nm,
    fm.color_nm as col_nm,
    fm.color_qty
FROM final_mapping fm
WHERE fm.individual_preview_cd != ''
ORDER BY
    fm.individual_preview_cd,
    fm.sty_cd