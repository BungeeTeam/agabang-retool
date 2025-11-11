-- 전체 옵션이 포함된 계층적 카테고리 쿼리
WITH base_categories AS (
    SELECT DISTINCT 
        large_cat, 
        middle_cat, 
        small_cat,
        -- br_cd = '07'인 경우 대분류와 중분류가 같은지 확인
        CASE WHEN '{{ var_brand_code.value }}' = '07' THEN 1 ELSE 0 END as is_brand_07,
        CASE WHEN middle_cat IS NULL THEN 1 ELSE 0 END as is_middle_null,
        -- middle_cat이 large_cat과 같은지 확인
        CASE WHEN middle_cat = large_cat THEN 1 ELSE 0 END as is_middle_same_as_large
    FROM agabang_dw.dim_style AS S
    WHERE S.br_cd = '{{ var_brand_code.value }}'  -- 브랜드 코드 조건 추가
      AND S.year_cd = substring('{{ select_season.value }}',1,1)
      AND S.season_cd = substring('{{ select_season.value }}',2,1)
      AND S.it NOT IN (6, 8, 9)
      AND S.large_cat IS NOT NULL
      AND S.large_cat != '캔슬'
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
    
    -- 각 대분류에 대한 "전체" 중분류 옵션 
    -- (br_cd = '07'이 아니고, middle_cat이 있고, middle_cat != large_cat인 경우만)
    SELECT DISTINCT
        CONCAT(large_cat, '/_ALL_') AS value,
        '전체' AS label,
        large_cat AS parent,
        1 as is_all_option
    FROM base_categories
    WHERE is_brand_07 = 0  -- br_cd = '07'이 아닌 경우
      AND is_middle_null = 0  -- middle_cat이 있는 경우
      AND is_middle_same_as_large = 0  -- middle_cat이 large_cat과 다른 경우만
    
    UNION ALL
    
    -- middle_cat이 NULL이거나 large_cat과 같은 경우 대분류 바로 아래 "전체" 옵션 추가
    SELECT DISTINCT
        CONCAT(large_cat, '/_ALL_') AS value,
        '전체' AS label,
        large_cat AS parent,
        1 as is_all_option
    FROM base_categories
    WHERE is_middle_null = 1  -- middle_cat이 NULL인 경우
       OR is_middle_same_as_large = 1  -- 또는 middle_cat이 large_cat과 같은 경우
    
    UNION ALL
    
    -- 실제 중분류 (대분류/중분류 형태) 
    -- br_cd = '07'이 아니고, middle_cat이 있고, middle_cat != large_cat인 경우만
    SELECT DISTINCT
        CONCAT(large_cat, '/', middle_cat) AS value,
        middle_cat AS label,
        large_cat AS parent,
        0 as is_all_option
    FROM base_categories
    WHERE middle_cat IS NOT NULL
      AND is_brand_07 = 0  -- br_cd = '07'이 아닌 경우에만 중분류 표시
      AND is_middle_same_as_large = 0  -- middle_cat이 large_cat과 다른 경우만
    
    UNION ALL
    
    -- 각 중분류에 대한 "전체" 소분류 옵션
    SELECT DISTINCT
        CASE 
            WHEN is_brand_07 = 1 OR is_middle_same_as_large = 1 THEN CONCAT(large_cat, '/_ALL_')  
            ELSE CONCAT(large_cat, '/', middle_cat, '/_ALL_')
        END AS value,
        '전체' AS label,
        CASE 
            WHEN is_brand_07 = 1 OR is_middle_same_as_large = 1 THEN large_cat  
            ELSE CONCAT(large_cat, '/', middle_cat)
        END AS parent,
        1 as is_all_option
    FROM base_categories
    WHERE middle_cat IS NOT NULL
      AND NOT (is_middle_same_as_large = 1 AND is_brand_07 = 0)  -- 중복 방지
    
    UNION ALL
    
    -- 실제 소분류 (대분류/중분류/소분류 형태)
    SELECT DISTINCT
        CASE 
            WHEN is_brand_07 = 1 OR is_middle_null = 1 OR is_middle_same_as_large = 1 
                THEN CONCAT(large_cat, '/', small_cat)  
            ELSE CONCAT(large_cat, '/', middle_cat, '/', small_cat)
        END AS value,
        small_cat AS label,
        CASE 
            WHEN is_brand_07 = 1 OR is_middle_null = 1 OR is_middle_same_as_large = 1 
                THEN large_cat  
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