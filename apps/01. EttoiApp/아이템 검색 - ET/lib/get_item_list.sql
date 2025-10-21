SELECT
distinct dim.sty_cd, dim.sty_nm, dim.col_cd, dim.col_nm,
        lower(replaceAll(concat(dim.sty_cd, dim.sty_nm, dim.col_nm),' ','')) as full_text
FROM agabang_dw.dim_style as dim
WHERE br_cd = '07' 
ORDER BY dim.year_cd desc, dim.season_cd desc
--limit 20000