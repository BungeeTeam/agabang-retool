SELECT
    year_season_cd as year_sesn_cd,
    --year_season_cd as year_sesn_nm_kor,
    count(*) as item_cnt,
    max(year_season_code) as season_order
FROM (
     SELECT A.sty_cd,
            A.sty_nm,
            case
                when A.year_season is not null then A.year_season
                else B.year_sesn_nm_eng
                end as year_season_cd,
            A.year_season             as md_info_year_season,
            B.year_sesn_nm_eng        as cod_year_season,
            substring(A.sty_cd, 5, 1) as category_code,
            A.item_raw_nm,
            concat(B.year_cd,B.sesn_cd) as year_season_code
     FROM agabang_dw.retooldb_item_md_info as A
       JOIN agabang_dw.code_season as B
         ON substring(A.sty_cd, 3, 2) = concat(B.year_cd, B.sesn_cd)
     where cast(A.br_cd as int) = cast({{ brand_code.value }} as int) and B.sesn_nm_eng != 'NO'
) as T
group by 1
order by 3 desc