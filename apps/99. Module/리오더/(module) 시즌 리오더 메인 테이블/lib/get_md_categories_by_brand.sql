-- 전체 옵션이 포함된 계층적 카테고리 쿼리
WITH base_categories AS (
    SELECT DISTINCT 
        large_cat, 
        middle_cat, 
        small_cat,
        -- br_cd = '07'인 경우 대분류와 중분류가 같은지 확인
        CASE WHEN '{{ var_brand_code.value }}' = '07' THEN 1 ELSE 0 END as is_brand_07,
        -- middle_cat이 NULL인 경우 체크 (0코드 등)
        CASE WHEN middle_cat IS NULL THEN 1 ELSE 0 END as is_middle_null
    FROM agabang_dw.dim_style AS S
    WHERE substring(S.sty_cd, 3, 1) = substring('{{ select_season.value}}', 1, 1)
      AND S.season_cd in (substring('{{ select_season.value}}', 2, 1))
      AND S.it NOT IN (6, 8, 9)
      AND large_cat IS NOT NULL
      AND (
        ('{{ var_brand_code.value }}' = '01'
         AND substring(S.sty_cd, 3, 1) >= 'J'
         AND (
           ('{{ select_brand.value }}' = 'all' AND S.br_cd = '01') OR
           ('{{ select_brand.value }}' = 'agabang' AND S.br_cd = '01')
         ))
        OR
        ('{{ var_brand_code.value }}' = '07'
         AND substring(S.sty_cd, 3, 1) >= 'M'
         AND S.large_cat != '캔슬'
         AND (
           S.br_cd = '07' AND
           (
             '{{ select_brand.value }}' = 'all' OR
             ('{{ select_brand.value }}' = 'liewood' AND (
               S.sub_br_nm in ('리우드', '오비디자인스', '노바디노즈')
             )) OR
             ('{{ select_brand.value }}' = 'ettoi' AND
              S.sub_br_nm not in ('리우드', '오비디자인스', '노바디노즈')
             )
           )
         ))
        OR
        ('{{ var_brand_code.value }}' = '79'
        AND (
          ('{{ select_brand.value }}' = 'all'
              AND S.br_cd = '79') OR
          ('{{ select_brand.value }}' = 'disney'
              AND S.br_cd = '79')
        ))
      )
)
SELECT DISTINCT
    value,
    label,
    parent,
    is_all_option -- 전체 옵션 여부 표시
FROM (
    -- 최상위 "전체" 옵션
    SELECT 
        '_ALL_' AS value,
        '전체' AS label,
        NULL AS parent,
        1 as is_all_option
    
    UNION ALL
    
    -- 대분류
    SELECT DISTINCT
        large_cat AS value,
        large_cat AS label,
        NULL AS parent,
        0 as is_all_option
    FROM base_categories
    
    UNION ALL
    
    -- 각 대분류에 대한 "전체" 중분류 옵션 (br_cd = '07'이 아니고 middle_cat이 있는 경우만)
    SELECT DISTINCT
        CONCAT(large_cat, '/_ALL_') AS value,
        '전체' AS label,
        large_cat AS parent,
        1 as is_all_option
    FROM base_categories
    WHERE is_brand_07 = 0  -- br_cd = '07'이 아닌 경우
      AND is_middle_null = 0  -- middle_cat이 있는 경우만
    
    UNION ALL
    
    -- middle_cat이 NULL인 경우 대분류 바로 아래 "전체" 옵션 추가
    SELECT DISTINCT
        CONCAT(large_cat, '/_ALL_') AS value,
        '전체' AS label,
        large_cat AS parent,
        1 as is_all_option
    FROM base_categories
    WHERE is_middle_null = 1  -- middle_cat이 NULL인 경우
    
    UNION ALL
    
    -- 실제 중분류 (대분류/중분류 형태) - br_cd = '07'이 아니고 middle_cat이 있는 경우만
    SELECT DISTINCT
        CONCAT(large_cat, '/', middle_cat) AS value,
        CASE 
            WHEN middle_cat = large_cat THEN CONCAT(middle_cat, ' (카테고리)')
            ELSE middle_cat 
        END AS label,
        large_cat AS parent,
        0 as is_all_option
    FROM base_categories
    WHERE middle_cat IS NOT NULL
      AND is_brand_07 = 0  -- br_cd = '07'이 아닌 경우에만 중분류 표시
    
    UNION ALL
    
    -- 각 중분류에 대한 "전체" 소분류 옵션
    SELECT DISTINCT
        CASE 
            WHEN is_brand_07 = 1 THEN CONCAT(large_cat, '/_ALL_')  -- br_cd = '07'인 경우 바로 대분류 하위에
            ELSE CONCAT(large_cat, '/', middle_cat, '/_ALL_')
        END AS value,
        '전체' AS label,
        CASE 
            WHEN is_brand_07 = 1 THEN large_cat  -- br_cd = '07'인 경우 대분류가 부모
            ELSE CONCAT(large_cat, '/', middle_cat)
        END AS parent,
        1 as is_all_option
    FROM base_categories
    WHERE middle_cat IS NOT NULL
    
    UNION ALL
    
    -- 실제 소분류 (대분류/중분류/소분류 형태)
    SELECT DISTINCT
        CASE 
            WHEN is_brand_07 = 1 THEN CONCAT(large_cat, '/', small_cat)  -- br_cd = '07'인 경우
            WHEN is_middle_null = 1 THEN CONCAT(large_cat, '/', small_cat)  -- middle_cat이 NULL인 경우
            ELSE CONCAT(large_cat, '/', middle_cat, '/', small_cat)
        END AS value,
        CASE 
            WHEN small_cat = middle_cat THEN CONCAT(small_cat, ' (상세)')
            ELSE small_cat 
        END AS label,
        CASE 
            WHEN is_brand_07 = 1 OR is_middle_null = 1 THEN large_cat  -- br_cd = '07'이거나 middle_cat이 NULL인 경우
            ELSE CONCAT(large_cat, '/', middle_cat)
        END AS parent,
        0 as is_all_option
    FROM base_categories
    WHERE small_cat IS NOT NULL
      
) AS combined_categories
ORDER BY 
    CASE 
        WHEN parent IS NULL THEN 0
        ELSE 1 
    END,
    parent,
    is_all_option DESC, -- 전체 옵션이 먼저 나오도록
    label