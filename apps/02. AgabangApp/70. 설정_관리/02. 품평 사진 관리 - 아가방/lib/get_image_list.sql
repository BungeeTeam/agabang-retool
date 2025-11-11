WITH folder_parsed AS (
    SELECT 
        SPLIT_PART('{{ sel_folder.value }}', '_', 1) as folder_year,
        SPLIT_PART('{{ sel_folder.value }}', '_', 2) as folder_season,
        SPLIT_PART('{{ sel_folder.value }}', '_', 3) as folder_category
),
season_mapping AS (
    SELECT 
        folder_year,
        folder_season,
        folder_category,
        -- folder_year를 기반으로 연도 코드를 동적으로 계산하도록 수정
        CASE 
            -- folder_year가 숫자이고 17(2017년) 이상일 경우
            WHEN folder_year ~ '^[0-9]+$' AND CAST(folder_year AS INTEGER) >= 17 THEN 
                -- 'K'(ASCII 75)를 기준으로 연도 차이만큼 더해 알파벳 코드 생성
                CHR(75 + (CAST(folder_year AS INTEGER) - 17))
            ELSE ''
        END as year_cd_filter,
        CASE folder_season
            WHEN 'SP' THEN '1'
            WHEN 'SM' THEN '3'
            WHEN 'FA' THEN '5'
            WHEN 'WT' THEN '7'
            WHEN 'NO' THEN '0'
            WHEN 'SS' THEN '1,3'
            WHEN 'FW' THEN '5,7'
            ELSE '0'
        END as sesn_cd_filter
    FROM folder_parsed
),
matched_items AS (
    -- get_matched_preview_cd_and_item 쿼리 로직
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
      AND (
        (sm.folder_category = '언더' AND rim.it_gb_cd IN ('11', '17', '51', '57'))
        OR (sm.folder_category = '의류' AND rim.it_gb_cd NOT IN ('11', '17', '51', '57'))
        OR (sm.folder_category NOT IN ('언더', '의류'))
      )
),
expanded_preview_codes AS (
    -- preview_cd가 '204/214' 형태인 경우 분리
    SELECT DISTINCT 
        UNNEST(STRING_TO_ARRAY(preview_cd, '/')) as preview_cd,
        sty_cd,
        sty_nm
    FROM matched_items
)
SELECT DISTINCT irb.*
FROM item_image_review_by_brand irb
WHERE irb.s3_key LIKE 'item_review/brand_code={{ var_brand_code.value }}/{{ sel_folder.value }}%'
  AND (
    {{ search_text.value.length }} = 0
    OR (
        {{ search_text.value.length }} > 0
        AND (
            -- 기존 s3_key 검색
            irb.s3_key LIKE '%{{ search_text.value }}%'
            OR
            -- 품평번호를 통한 상품명/스타일코드 검색
            EXISTS (
                SELECT 1
                FROM expanded_preview_codes epc
                WHERE 
                    -- s3_key에서 품평번호 추출
                    REPLACE(REPLACE(SPLIT_PART(irb.s3_key, '/', -1), '.jpg', ''), '.png', '') = epc.preview_cd
                    AND (
                        LOWER(epc.sty_nm) LIKE LOWER('%{{ search_text.value }}%')
                        OR LOWER(epc.sty_cd) LIKE LOWER('%{{ search_text.value }}%')
                    )
            )
        )
    )
  )
ORDER BY irb.s3_key