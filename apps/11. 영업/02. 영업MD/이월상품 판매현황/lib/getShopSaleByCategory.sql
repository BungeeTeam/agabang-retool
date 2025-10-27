-- carryover sale query
with
    toDate('{{p_endDate}}') as endDate,
    '{{ brandMultiSelect2.value }}' as brand_code,
    '{{ yearSelect2.selectedItem.season_cd }}' as season_code,
    '{{ bizMultiSelect2.value }}' as biz_code,
    toDate('{{ p_seasonEndDate }}') as seasonEndDate,
({{ p_year_codes }}) as year_code,
[{{ p_year_codes }}] as year_code_array,
  
    itemBase as(
        SELECT
        distinct sty_cd, tag_price,year_nm, year_cd,
           CASE WHEN year_cd = year_code_array[1] THEN 'B'
                WHEN year_cd = year_code_array[2] THEN 'C'
                WHEN year_cd = year_code_array[3] THEN 'D'
               ELSE 'under D' END as item_grade,
           CASE WHEN it = '1' THEN '시즌언더'
    WHEN it = '2' THEN '시즌의류(B)'
    WHEN it = '3' THEN '시즌의류(T)'
    WHEN it = '4' THEN '파자마'
    WHEN it = '5' AND it_gb = '57' THEN '기획언더'
    WHEN it = '5' THEN '기획의류'
    WHEN it = '6' THEN '위탁용품'
    WHEN it = '7' THEN '시즌용품'
    WHEN it = '8' THEN '일반용품'
    WHEN it = '9' THEN '판촉부자재'
  ELSE '기타' END AS category_name,
          CASE WHEN it = '1' THEN '2'
    WHEN it = '2' THEN '0'
    WHEN it = '3' THEN '1'
    WHEN it = '4' THEN '3'
    WHEN it = '5' AND it_gb = '57' THEN '6'
    WHEN it = '5' THEN '5'
    WHEN it = '6' THEN '7'
    WHEN it = '7' THEN '4'
    WHEN it = '8' THEN '8'
    WHEN it = '9' THEN '9'
  ELSE '기타' END AS category_order
    FROM agabang_dw.dim_style
    WHERE year_cd in year_code
    and it in ('1','2','3','4','5','7')
    and br_cd = brand_code
    and season_cd = season_code
    )
SELECT
    B.biz_cd as biz_cd, 
    B.biz_nm as biz_nm, 
    B.br_cd as br_cd, 
    B.br_nm as br_nm,
    B.shop_cd as shop_cd, 
    B.shop_nm as shop_nm, 
    B.tp_cd as tp_cd,
    B.tp_nm as tp_nm,
    B.year_cd as year_cd, 
    B.year_nm as year_nm, 
    B.season_cd as season_cd, 
    B.season_nm as season_nm, 
    B.onoff_flag as onoff_flag, 
    concat(B.year_cd,B.season_cd) as year_season_cd,
    A.category_name, A.category_order, A.item_grade,
    sum(B.sales_qty*A.tag_price) as sale_tag,
  sum(B.sales_qty) as sale_qty,
  sum(B.sales_price) as sale_amt
FROM agabang_dw.daily_shop_sales_by_dimension as B
LEFT JOIN itemBase as A ON A.sty_cd = B.sty_cd
WHERE
  B.sale_dt between seasonEndDate and endDate
  and A.year_cd in year_code
  and B.sales_type = '이월'
  -- and B.it in ('1','2','3','4','5','7')
  and B.biz_cd = biz_code and B.br_cd in (brand_code) and B.season_cd = season_code
GROUP BY B.biz_cd, B.biz_nm,
         B.br_cd, B.br_nm,
         B.shop_cd, B.shop_nm,
         B.tp_cd, B.tp_nm,
         B.year_cd, B.year_nm,
         B.season_cd, B.season_nm,
         B.onoff_flag,
         A.category_name, A.category_order, A.item_grade;