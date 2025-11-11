SELECT
    year_season_cd as year_sesn_cd,
    case
        when year_season_cd = 'BIRTH' then '출산용품'
        when year_season_cd = 'NO' then '무시즌'
        else year_season_cd
    end year_sesn_nm_kor,
    count(*) as item_cnt
FROM (
     SELECT A.sty_cd,
            A.sty_nm,
            case
                when A.year_season is not null then A.year_season
                when B.sesn_cd in (1, 3, 5, 7) then B.year_sesn_nm_eng
                when (B.sesn_nm_eng = 'NO' and substring(A.sty_cd, 5, 1) = '8' and
                      A.item_raw_nm not in ('속싸개', '손싸보')) then 'BIRTH'
                else 'NO'
                end year_season_cd,
            A.year_season             as md_info_year_season,
            B.year_sesn_nm_eng        as cod_year_season,
            substring(A.sty_cd, 5, 1) as category_code,
            A.item_raw_nm
     FROM agabang_dw.retooldb_item_md_info as A
     JOIN agabang_dw.code_season as B
     ON substring(A.sty_cd, 3, 2) = concat(B.year_cd, B.sesn_cd)
      where cast(A.br_cd as int) = cast({{ localStorage.values.br_cd }} as int)
) as T
group by 1
order by 1 desc