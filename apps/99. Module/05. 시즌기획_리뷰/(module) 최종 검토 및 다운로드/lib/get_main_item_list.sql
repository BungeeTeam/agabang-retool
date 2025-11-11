-- get_main_item_list.sql

WITH 
  '{{var_brand_code.value}}' as brand_code,
  
-- dim_style의 데이터
dim_data AS (
    SELECT DISTINCT
        ds.sty_cd as sty_cd,
        ds.col_cd as col_cd,
        ds.sty_nm as sty_nm,
        ds.col_nm as col_nm,
        ds.fabric as fabric,
        ds.preview_grade as preview_grade,
        ds.preview_score as preview_score,
        ds.opinion as opinion,
        ds.large_cat as large_cat,
        ds.middle_cat as middle_cat,
        ds.small_cat as small_cat,
        ima.md_memo as md_memo,
        ima.final_lot as final_lot,
        ima.final_memo as final_memo,
        ima.price_memo as price_memo,
        ima.final_assort as final_assort,
        1 as data_source -- 1: dim_style
    FROM agabang_dw.dim_style as ds
    JOIN agabang_dw.retooldb_item_md_assort as ima
        ON concat(ds.sty_cd, ds.col_cd) = ima.sty_col_cd
    WHERE ds.br_cd = brand_code
      AND ds.year_cd = substring('{{ select_season.value }}', 1, 1)
      AND ds.season_cd = substring('{{ select_season.value }}', 2, 1)
      AND ds.comp_cd = 'AG001'
      AND ima.final_check = TRUE
),

-- retooldb_item_md_info의 실시간 데이터 (dim_style에 없는 것만)
realtime_data AS (
    SELECT DISTINCT
        imi.sty_cd as sty_cd,
        pc.col_cd as col_cd,
        imi.sty_nm as sty_nm,
        plc.col_nm as col_nm,
        imi.fabric as fabric,
        imi.preview_grade as preview_grade,
        imi.preview_score as preview_score,
        imi.opinion as opinion,
        COALESCE(imc.cat_nm, imi.cat_raw_nm) as large_cat,
        imi.cat_nm as middle_cat,
        imi.item_raw_nm as small_cat,
        ima.md_memo as md_memo,
        ima.final_lot as final_lot,
        ima.final_memo as final_memo,
        ima.price_memo as price_memo,
        ima.final_assort as final_assort,
        2 as data_source -- 2: realtime
    FROM agabang_dw.retooldb_item_md_info as imi
    INNER JOIN agabang.plcoszcd pc ON imi.sty_cd = pc.sty_cd
    INNER JOIN agabang.plcolcd plc ON pc.col_cd = plc.col_cd
    LEFT JOIN agabang_dw.retooldb_item_md_category as imc
        ON imi.item_md_category_id = imc.id
    LEFT JOIN agabang_dw.retooldb_item_md_assort as ima
        ON concat(imi.sty_cd, pc.col_cd) = ima.sty_col_cd
    LEFT JOIN dim_data dd 
        ON imi.sty_cd = dd.sty_cd AND pc.col_cd = dd.col_cd
    WHERE substring(imi.sty_cd, 1, 2) = brand_code
      AND imi.year_cd = substring('{{ select_season.value }}', 1, 1)
      AND imi.sesn_cd = substring('{{ select_season.value }}', 2, 1)
      AND ima.final_check = TRUE
      AND dd.sty_cd IS NULL -- dim_style에 없는 것만
),

-- 전체 데이터 합치기
all_data AS (
    SELECT * FROM dim_data
    UNION ALL
    SELECT * FROM realtime_data
)

SELECT 
    sty_cd,
    col_cd,
    sty_nm,
    col_nm,
    fabric,
    preview_grade,
    preview_score,
    opinion,
    large_cat,
    middle_cat,
    small_cat,
    md_memo,
    final_lot,
    final_memo,
    price_memo,
    final_assort,
    data_source
FROM all_data
WHERE 
  -- 카테고리 필터링 조건
  (
    -- 전체 선택인 경우 (large_all이 true)
    '{{ parse_cascader_path.data.large_all }}' = 'true'
    OR
    -- 대분류가 선택된 경우
    (
      '{{ parse_cascader_path.data.large_cat }}' != 'null'
      AND '{{ parse_cascader_path.data.large_cat }}' != ''
      AND large_cat = '{{ parse_cascader_path.data.large_cat }}'
      AND (
        -- 대분류만 선택한 경우 (중분류가 null)
        '{{ parse_cascader_path.data.middle_cat }}' = 'null'
        OR
        -- 중분류 전체 선택
        '{{ parse_cascader_path.data.middle_all }}' = 'true'
        OR
        -- 중분류가 선택된 경우
        (
          '{{ parse_cascader_path.data.middle_cat }}' != 'null'
          AND (
            -- middle_cat이 NULL인 경우 처리 (0코드 등)
            ('{{ parse_cascader_path.data.is_middle_null }}' = 'true' AND middle_cat IS NULL)
            OR
            -- 일반적인 중분류 매칭
            ('{{ parse_cascader_path.data.is_middle_null }}' = 'false' 
              AND middle_cat = '{{ parse_cascader_path.data.middle_cat }}')
          )
          AND (
            -- 중분류까지만 선택한 경우 (소분류가 null)
            '{{ parse_cascader_path.data.small_cat }}' = 'null'
            OR
            -- 소분류 전체 선택
            '{{ parse_cascader_path.data.small_all }}' = 'true'
            OR
            -- 소분류가 선택된 경우
            ('{{ parse_cascader_path.data.small_cat }}' != 'null'
              AND small_cat = '{{ parse_cascader_path.data.small_cat }}')
          )
        )
      )
    )
  )
ORDER BY 
    data_source, -- dim_style 데이터를 먼저 보여줌
    large_cat,
    middle_cat,
    small_cat,
    sty_nm;