select * from ( 
  SELECT
      case
          when year_season_cd = 'BIRTH' then 'birth'
          when year_season_cd = 'NO' then 'no'
          else 'season'
      end season_type,
      year_season_cd as year_sesn_cd,
      case
          when year_season_cd = 'BIRTH' then '출산용품'
          when year_season_cd = 'NO' then '무시즌'
          else concat('시즌-', year_season_cd)
      end year_sesn_nm_kor,
      case
          when year_season_cd = 'BIRTH' then 99
          when year_season_cd = 'NO' then 88
          when toInt32(year_nm) > toYear(now())-1 then 1
          else 5
      end year_season_order,
      count(*) as item_cnt,
      max(year_sesn_ord) as year_season_order2,
      min(year_nm) as year_number
  FROM (
       SELECT A.sty_cd,
              A.sty_nm,
              A.br_cd,
              case
                  when A.year_season is not null then A.year_season
                  when B.sesn_cd in (1, 3, 5, 7) then B.year_sesn_nm_eng
                  when (B.sesn_nm_eng = 'NO' and substring(A.sty_cd, 5, 1) = '8' and
                        A.item_raw_nm not in ('손싸개', '속싸보', '턱받이')) then 'BIRTH'
                  else 'NO'
                  end year_season_cd,
              A.year_season             as md_info_year_season,
              B.year_sesn_nm_eng        as cod_year_season,
              substring(A.sty_cd, 5, 1) as category_code,
              A.item_raw_nm,
              B.year_nm,
              B.year_sesn_cd as year_sesn_ord
       FROM agabang_dw.retooldb_item_md_info as A
       JOIN agabang_dw.code_season as B
       ON substring(A.sty_cd, 3, 2) = concat(B.year_cd, B.sesn_cd)
       WHERE substring(A.sty_cd, 5, 1) != '9'
        AND cast(A.br_cd as int) = cast({{ variable0 }} as int)
  -- AND (A.sty_nm not like '%부가부%' and A.sty_nm not like '%두나%' and A.sty_nm not like '%디트로네%' and A.sty_nm not like '%리우드%' and A.sty_nm not like '%노바디노즈%' and A.sty_nm not like '%콩제슬레드%')
  ) as T
  group by 1,2,3,4

) as T
order by 4 asc, 6 desc, 2 desc