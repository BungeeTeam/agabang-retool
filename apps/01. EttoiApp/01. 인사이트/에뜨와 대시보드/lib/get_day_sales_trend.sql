with 
  '07' as brand_code,
STY_SEASON as (
  SELECT
    A.sty_cd,
    A.sty_nm,
    case
       when A.year_season is not null then A.year_season
       when B.sesn_cd in (1, 3, 5, 7) then B.year_sesn_nm_eng
       when (B.sesn_nm_eng = 'NO' and substring(A.sty_cd, 5, 1) = '8' and
             A.item_raw_nm not in ('손싸개', '속싸보', '턱받이')) then 'BIRTH'
       else 'NO'
       end                      year_season_cd,
    A.year_season             as md_info_year_season,
    B.year_sesn_nm_eng        as code_year_season,
    substring(A.sty_cd, 5, 1) as category_code,
    A.item_raw_nm
  FROM agabang_dw.retooldb_item_md_info as A
  JOIN agabang_dw.code_season as B
    ON substring(A.sty_cd, 3, 2) = concat(B.year_cd, B.sesn_cd)  
  WHERE A.br_cd = brand_code
)
SELECT
  A.sale_dt as sale_dt,
  A.sale_gb as sale_gb,
  sum(A.sales_qty) as sales_qty,
  sum(A.sales_price) as sales_price
FROM agabang_dw.day_shop_sty_sales as A
JOIN STY_SEASON as B
  ON A.sty_cd = B.sty_cd
where 1 = 1
  and A.br_cd = brand_code
  and A.sale_dt >= '{{dateRange_day.value.start}}'
  and A.sale_dt <= '{{dateRange_day.value.end}}'
  and ( '{{ select_shop.value == null ? '' : select_shop.value }}' = '' or A.shop_nm = '{{ select_shop.value == null ? '' : select_shop.value }}' )
  and ( '{{ select_style.value == null ? '' : select_style.value }}' = '' or A.sty_cd = '{{ select_style.value == null ? '' : select_style.value }}' )
  and ( '{{ select_season.value == null ? '' : select_season.value }}' = '' or B.year_season_cd = '{{ select_season.value == null ? '' : select_season.value  }}' )
  and ( '{{ switch_exclude_stroller.value }}' = 'false' or ( A.sty_nm not like '부가부%'
    and A.sty_nm not like '요요%'
    and A.sty_nm not like '디트로네%'
    and A.sty_nm not like '두나%') )
group by 1,2
order by 1 asc, 2 asc