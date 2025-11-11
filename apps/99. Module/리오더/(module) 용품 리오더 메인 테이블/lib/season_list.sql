-- season_list 대체 쿼리: 브랜드별 모든 시즌 정보 및 시작일 조회
WITH first_outbound AS (
    SELECT 
        d.br_cd,
        s.year_cd,
        s.season_cd,
        s.year_nm,
        s.season_nm,
        MIN(d.wrk_dt) AS first_out_date,
        -- 첫 출고일 + 1일을 시즌 시작일로 설정
        MIN(d.wrk_dt) + INTERVAL 1 DAY AS season_start_date
    FROM agabang_dw.daily_dsoutrtn d
    INNER JOIN agabang_dw.dim_style s 
        ON d.sty_cd = s.sty_cd 
        AND d.col_cd = s.col_cd 
        AND d.size_cd = s.size_cd
    WHERE d.br_cd = '{{ var_brand_code.value }}' -- 현재 브랜드 코드
        AND d.out_qty > 0
        AND s.season_cd != '0' -- 정규 시즌만
        AND s.year_cd >= 'Q'    -- 2023년 이후
    GROUP BY 
        d.br_cd,
        s.year_cd,
        s.season_cd,
        s.year_nm,
        s.season_nm
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
    first_out_date,
    season_start_date,
    toMonth(season_start_date) AS start_month,
    toDayOfMonth(season_start_date) AS start_day,
    -- 연도-시즌 조합 코드 추가
    CONCAT(year_cd, season_cd) AS season_code
FROM first_outbound
ORDER BY season_start_date DESC -- 최신 시즌부터 정렬