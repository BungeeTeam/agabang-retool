WITH
    '{{ brandMultiSelect2.value }}' as brand_code,

    filtered_dim as(
        SELECT
        distinct br_cd, br_nm, year_cd, year_nm, season_cd, season_nm, season_end_dt
    FROM agabang_dw.dim_style
    WHERE br_cd in (brand_code)
    and season_cd in ('1','3','5','7')
    ),
      filtered_sales as(
        SELECT
        distinct br_cd, br_nm, year_cd, toInt32OrZero(year_nm) as year_nm, season_cd, season_nm, season_end_dt
    FROM agabang_dw.daily_shop_sales_by_dimension
    WHERE br_cd in (brand_code)
    and biz_cd = '{{ bizMultiSelect2.value }}'
    and sales_type = '이월'
    and season_cd in ('1','3','5','7')
    )

SELECT
    distinct
    br_nm, br_cd,
    year_cd, year_nm,
    season_cd,
    season_nm,
    season_end_dt,
    concat(year_cd,season_cd) as year_season_cd,
    s2.year_nm as last_year_nm,
    s2.year_cd as last_year_cd,
    s2.season_end_dt as last_season_end_dt,
    concat(s2.year_cd,s2.season_cd) as last_year_season_cd,
    array(
        char(ascii(year_cd) - 1),
        char(ascii(year_cd) - 2),
        char(ascii(year_cd) - 3)
    ) AS year_codes,
    array(
        char(ascii(year_cd) - 2),
        char(ascii(year_cd) - 3),
        char(ascii(year_cd) - 4)
    ) AS prev_year_codes
FROM filtered_dim
-- LEFT JOIN filtered_dim as s2
-- ON s2.br_cd = br_cd and  CAST(s2.year_nm as INT) +1 = CAST(year_nm as INT) and s2.season_cd = season_cd
JOIN filtered_sales as s2
ON s2.br_cd = br_cd and  CAST(s2.year_nm as INT) +1 = CAST(year_nm as INT) and s2.season_cd = season_cd
WHERE year_nm >= toString(toYear(today())-1)
ORDER BY br_nm,year_cd desc, season_cd desc;