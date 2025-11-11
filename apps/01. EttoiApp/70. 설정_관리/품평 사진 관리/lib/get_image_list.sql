-- 1. 폴더명으로 연관 상품 정보를 미리 조회하는 CTE
WITH folder_parsed AS (
    SELECT
        -- 작은따옴표 치환 추가
        SPLIT_PART('{{ sel_folder.value.replace("'", "''") }}', '''', 1) as folder_year,
        -- 작은따옴표 치환 추가
        SUBSTRING('{{ sel_folder.value.replace("'", "''") }}' FROM '([A-Z]+)') as folder_season
),
season_mapping AS (
    SELECT
        folder_year,
        folder_season,
        CASE
            WHEN folder_year ~ '^[0-9]+$' AND CAST(folder_year AS INTEGER) >= 17 THEN
                CHR(75 + (CAST(folder_year AS INTEGER) - 17))
            ELSE ''
        END as year_cd_filter
    FROM folder_parsed
),
matched_items AS (
    SELECT DISTINCT
        rim.preview_cd,
        rim.sty_cd,
        rim.sty_nm
    FROM item_md_info rim
    CROSS JOIN season_mapping sm
    WHERE rim.br_cd = '{{ var_brand_code.value }}'
      AND rim.preview_cd IS NOT NULL
      AND rim.preview_cd != ''
      AND rim.year_cd = sm.year_cd_filter
      AND (
          (sm.folder_season = 'SP' AND rim.sesn_cd in ('1', '2'))
          OR (sm.folder_season = 'SM' AND rim.sesn_cd in ('3', '4'))
          OR (sm.folder_season = 'FA' AND rim.sesn_cd in ('5', '6'))
          OR (sm.folder_season = 'WT' AND rim.sesn_cd in ('7', '8'))
          OR (sm.folder_season = 'NO' AND rim.sesn_cd = '0')
          OR (sm.folder_season = 'SS' AND rim.sesn_cd IN ('1', '2', '3', '4'))
          OR (sm.folder_season = 'FW' AND rim.sesn_cd IN ('5', '6', '7', '8'))
      )
),
expanded_preview_codes AS (
    SELECT DISTINCT
        UNNEST(STRING_TO_ARRAY(preview_cd, '/')) as preview_cd,
        sty_cd,
        sty_nm
    FROM matched_items
)

-- 2. 최종 데이터 조회
SELECT
    *
FROM
    item_image_review
WHERE
    -- 작은따옴표 치환 (이 부분은 이미 올바르게 되어 있었음)
    s3_key LIKE 'item_review/{{ sel_folder.value.replace("'", "''") }}%'
    AND (
        s3_key ILIKE '%{{ search_text.value }}%'
        OR EXISTS (
            SELECT 1
            FROM expanded_preview_codes epc
            WHERE
                REPLACE(SPLIT_PART(s3_key, '/', -1), '.jpg', '') = epc.preview_cd
                AND (
                    epc.sty_nm ILIKE '%{{ search_text.value }}%'
                    OR epc.sty_cd ILIKE '%{{ search_text.value }}%'
                )
        )
        OR {{ !search_text.value }}
    )
ORDER BY
    s3_key;