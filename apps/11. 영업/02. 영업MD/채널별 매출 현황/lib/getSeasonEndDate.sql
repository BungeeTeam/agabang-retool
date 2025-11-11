WITH
    '{{brandSelect.value}}' as brand_code

SELECT
    distinct 
  br_nm,
  year_cd as year_cd_ly,
  concat(substring(CAST(year_nm as String),3,2),'년 ',season_nm) as year_season_kor,
  CAST(year_nm as INT) + 1 as year_nm,
  season_cd,season_nm, season_end_dt, 
  concat(year_cd,season_cd) as year_season_cd
FROM agabang_dw.dim_style
WHERE br_cd in (brand_code)
and year_nm >= toString(toYear(today())-1)
and season_cd in ('0','1','3','5','7')
and season_end_dt < today()
ORDER BY br_nm,year_cd desc, season_cd desc