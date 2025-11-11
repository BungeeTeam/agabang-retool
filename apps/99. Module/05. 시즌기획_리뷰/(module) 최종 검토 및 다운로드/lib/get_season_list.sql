WITH seasons AS (
    SELECT distinct
        br_cd,
        year_cd,
        season_cd,
        year_nm,
        season_nm,        -- 첫 출고일 + 1일을 시즌 시작일로 설정
    FROM agabang_dw.dim_style
    WHERE br_cd = '{{ var_brand_code.value }}' -- 현재 브랜드 코드
          and year_cd >= 'S'
)
SELECT 
    br_cd,
    year_cd,
    year_nm,
    season_cd AS sesn_cd, -- season_list와 호환되도록 컬럼명 변경
    CASE
        WHEN season_cd IN ('2', '4', '6', '8') THEN CONCAT(season_nm, ' (마트)')
        ELSE season_nm
    END AS sesn_nm,    -- season_list와 호환되도록 컬럼명 변경
    -- 연도-시즌 조합 코드 추가
    CONCAT(year_cd, season_cd) AS season_code
FROM seasons
ORDER BY year_cd DESC, season_cd DESC -- 최신 시즌부터 정렬