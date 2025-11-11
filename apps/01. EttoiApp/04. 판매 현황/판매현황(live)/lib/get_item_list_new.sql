WITH
'{{segmentedControl_date_mode.value == "cumulative" ? moment(`${select_season.selectedItem.year_nm}-01-01`).subtract(1, 'years').format('YYYY-MM-DD'): sel_start_date.value.substring(0,10)}}' as start_date,
'{{segmentedControl_date_mode.value == "cumulative" ? new Date().toISOString().split('T')[0] : sel_end_date.value.substring(0,10)}}' as end_date,
'{{select_season.selectedItem.year_sesn_cd}}' as sel_sesn_cd,
'{{select_season.value}}' as year_sesn_eng_nm,
--'{{ var_brand_code.value }}' as brand_code,
      ({{ select_item_type.value === 'yongpum' ?
  select_brand.value.map(i => `'${i}'`).join(',')
  :`'${var_brand_code.value}'` }}) as brand_code,

STY_SEASON AS (
SELECT
      distinct
      A.sty_cd as sty_cd,
      A.sty_nm as sty_nm,
      A.item_md_category_id as item_md_category_id,
      A.large_cat as large_cat,
      A.fabric as fabric,
      case when B.sesn_cd in (1, 3, 5, 7) then B.year_sesn_nm_eng
           else 'NO' end              as year_season_cd,
      null                            as md_info_year_season,
      B.year_sesn_nm_eng       as cod_year_season,
      A.it      as category_code,
      A.small_cat               as item_raw_nm,
      A.it_gb_nm as it_gb_nm,
      A.item_nm as item_nm,
      CASE WHEN A.season_cd in ('2','4','6','8') THEN 'mart'
                WHEN A.season_cd = '0' and it in ('6','8') THEN 'yongpum'
                WHEN A.season_cd = '0' and it in ('1','2','3','5','7') THEN 'season_less'
                ELSE 'season' END as index
    FROM agabang_dw.dim_style as A
    JOIN agabang_dw.code_season as B
          ON substring(A.sty_cd,3,2) = concat(B.year_cd,B.sesn_cd)
    WHERE A.br_cd in brand_code
      and substring(A.sty_cd, 5, 1) != '9'
      and B.year_sesn_nm_eng = year_sesn_eng_nm
    order by A.sty_cd
),
SALE_DATA AS (
select
        sty_cd, col_cd, col_nm,
        SUM(sale_qty) as sale_qty_tot,
        SUM(sale_amt) as sale_amt_tot,
  
        SUM(CASE WHEN A.size_nm = '3M' THEN sale_qty ELSE 0 END) AS sale_qty_3m,
        SUM(CASE WHEN A.size_nm = '6M' THEN sale_qty ELSE 0 END) AS sale_qty_6m,
        SUM(CASE WHEN A.size_nm = '12M' THEN sale_qty ELSE 0 END) AS sale_qty_12m,
        SUM(CASE WHEN A.size_nm = '18M' THEN sale_qty ELSE 0 END) AS sale_qty_18m,
        SUM(CASE WHEN A.size_nm = '2Y' THEN sale_qty ELSE 0 END) AS sale_qty_2y,
        SUM(CASE WHEN A.size_nm = '3Y' THEN sale_qty ELSE 0 END) AS sale_qty_3y,
        SUM(CASE WHEN A.size_nm = '4Y' THEN sale_qty ELSE 0 END) AS sale_qty_4y,
        MAX(CASE WHEN B.size_nm = '3M' THEN tot_in_qty ELSE 0 END) AS tot_in_qty_3m,
        MAX(CASE WHEN B.size_nm = '6M' THEN tot_in_qty ELSE 0 END) AS tot_in_qty_6m,
        MAX(CASE WHEN B.size_nm = '12M' THEN tot_in_qty ELSE 0 END) AS tot_in_qty_12m,
        MAX(CASE WHEN B.size_nm = '18M' THEN tot_in_qty ELSE 0 END) AS tot_in_qty_18m,
        MAX(CASE WHEN B.size_nm = '2Y' THEN tot_in_qty ELSE 0 END) AS tot_in_qty_2y,
        MAX(CASE WHEN B.size_nm = '3Y' THEN tot_in_qty ELSE 0 END) AS tot_in_qty_3y,
        MAX(CASE WHEN B.size_nm = '4Y' THEN tot_in_qty ELSE 0 END) AS tot_in_qty_4y,

  -- 01,01,00
    sum(case when A.size_cd='01' and A.size_tp='00' then sale_qty
             else 0 end) as sale_qty_01,    --
    max(case when A.size_cd='01' and A.size_tp='00' then tot_in_qty
             else 0 end) as tot_in_qty_01,

  -- 03,03,00
    sum(case when A.size_cd='03' and A.size_tp='00' then sale_qty
             else 0 end) as sale_qty_03,    --
    max(case when A.size_cd='03' and A.size_tp='00' then tot_in_qty
             else 0 end) as tot_in_qty_03,

  -- 01,신생아,88
    sum(case when A.size_cd='01' and A.size_tp='88' then sale_qty
             else 0 end) as sale_qty_newborn,    -- 신생아
    max(case when A.size_cd='01' and A.size_tp='88' then tot_in_qty
             else 0 end) as tot_in_qty_newborn,

--   01,Free,99
-- 99,FREE,81
-- 99,FREE,86
-- 99,FREE,83
  -- 04,Free,84
    sum(case when A.size_cd='01' and A.size_tp='99' then sale_qty
             when A.size_cd='99' and A.size_tp='81' then sale_qty
             when A.size_cd='99' and A.size_tp='83' then sale_qty
             when A.size_cd='99' and A.size_tp='86' then sale_qty
             when A.size_cd='04' and A.size_tp='84' then sale_qty
             else 0 end) as sale_qty_free,    -- free
    max(case when A.size_cd='01' and A.size_tp='99' then tot_in_qty
             when A.size_cd='99' and A.size_tp='81' then tot_in_qty
             when A.size_cd='99' and A.size_tp='83' then tot_in_qty
             when A.size_cd='99' and A.size_tp='86' then tot_in_qty
             when A.size_cd='04' and A.size_tp='84' then tot_in_qty
             else 0 end) as tot_in_qty_free,

--     01,100X120,85
-- 01,100X120,86
    sum(case when A.size_cd='01' and A.size_tp='85' then sale_qty
             when A.size_cd='01' and A.size_tp='86' then sale_qty
             else 0 end) as sale_qty_100X120,    -- 
    max(case when A.size_cd='01' and A.size_tp='85' then tot_in_qty
             when A.size_cd='01' and A.size_tp='86' then tot_in_qty
             else 0 end) as tot_in_qty_100X120,

--   02,100X130,85
-- 03,100X130,86
-- 06,100X130,81
    sum(case when A.size_cd='02' and A.size_tp='85' then sale_qty
             when A.size_cd='03' and A.size_tp='86' then sale_qty
             when A.size_cd='06' and A.size_tp='81' then sale_qty
             else 0 end) as sale_qty_100X130,    -- 
    max(case when A.size_cd='02' and A.size_tp='85' then tot_in_qty
             when A.size_cd='03' and A.size_tp='86' then tot_in_qty
             when A.size_cd='06' and A.size_tp='81' then tot_in_qty
             else 0 end) as tot_in_qty_100X130,

  -- 02,83X83,84
    sum(case when A.size_cd='02' and A.size_tp='84' then sale_qty
             else 0 end) as sale_qty_83X83,    -- 
    max(case when A.size_cd='02' and A.size_tp='84' then tot_in_qty
             else 0 end) as tot_in_qty_83X83,

  -- 01,85X85,84
    sum(case when A.size_cd='01' and A.size_tp='84' then sale_qty
             else 0 end) as sale_qty_85X85,    -- 
    max(case when A.size_cd='01' and A.size_tp='84' then tot_in_qty
             else 0 end) as tot_in_qty_85X85,

  -- 01,95X95,82
    sum(case when A.size_cd='01' and A.size_tp='82' then sale_qty
             else 0 end) as sale_qty_95X95,    -- 
    max(case when A.size_cd='01' and A.size_tp='82' then tot_in_qty
             else 0 end) as tot_in_qty_95X95,

  -- 03,105X135,81
    sum(case when A.size_cd='03' and A.size_tp='81' then sale_qty
             else 0 end) as sale_qty_105X135,    -- 
    max(case when A.size_cd='03' and A.size_tp='81' then tot_in_qty
             else 0 end) as tot_in_qty_105X135,

  -- 04,115X145,81
    sum(case when A.size_cd='04' and A.size_tp='81' then sale_qty
             else 0 end) as sale_qty_115X145,    -- 
    max(case when A.size_cd='04' and A.size_tp='81' then tot_in_qty
             else 0 end) as tot_in_qty_115X145,

  -- 01,미니처네,83
    sum(case when A.size_cd='01' and A.size_tp='83' then sale_qty
             else 0 end) as sale_qty_mini,    -- 미니처네
    max(case when A.size_cd='01' and A.size_tp='83' then tot_in_qty
             else 0 end) as tot_in_qty_mini,

  -- 01,일반,90
    sum(case when A.size_cd='01' and A.size_tp='90' then sale_qty
             else 0 end) as sale_qty_general,    -- 일반
    max(case when A.size_cd='01' and A.size_tp='90' then tot_in_qty
             else 0 end) as tot_in_qty_general,

  -- 02,7부처네,83
    sum(case when A.size_cd='02' and A.size_tp='83' then sale_qty
             else 0 end) as sale_qty_seven,    -- 7부처네
    max(case when A.size_cd='02' and A.size_tp='83' then tot_in_qty
             else 0 end) as tot_in_qty_seven,


  -- 11,65,10
    sum(case when A.size_cd='11' and A.size_tp='10' then sale_qty
             else 0 end) as sale_qty_65,    -- 60
    max(case when A.size_cd='11' and A.size_tp='10' then tot_in_qty
             else 0 end) as tot_in_qty_65,

  -- 12,70,10
    sum(case when A.size_cd='12' and A.size_tp='10' then sale_qty
             else 0 end) as sale_qty_70,    -- 60
    max(case when A.size_cd='12' and A.size_tp='10' then tot_in_qty
             else 0 end) as tot_in_qty_70,

  -- 15,85,10
  -- 15,85,11
    sum(case when A.size_cd='15' and A.size_tp='10' then sale_qty
             when A.size_cd='15' and A.size_tp='11' then sale_qty
             else 0 end) as sale_qty_85,    -- 60
    max(case when A.size_cd='15' and A.size_tp='10' then tot_in_qty
             when A.size_cd='15' and A.size_tp='11' then tot_in_qty
             else 0 end) as tot_in_qty_85,

  -- 17,95,11
  -- 17,95,10
    sum(case when A.size_cd='17' and A.size_tp='10' then sale_qty
             when A.size_cd='17' and A.size_tp='11' then sale_qty
             else 0 end) as sale_qty_95,    -- 60
    max(case when A.size_cd='17' and A.size_tp='10' then tot_in_qty
             when A.size_cd='17' and A.size_tp='11' then tot_in_qty
             else 0 end) as tot_in_qty_95,

  -- 39,145,30
    -- 39,145,40
    sum(case when A.size_cd='39' and A.size_tp='30' then sale_qty
             when A.size_cd='39' and A.size_tp='40' then sale_qty
             else 0 end) as sale_qty_145,    -- 
    max(case when A.size_cd='39' and A.size_tp='30' then tot_in_qty
             when A.size_cd='39' and A.size_tp='40' then tot_in_qty
             else 0 end) as tot_in_qty_145,

  -- 41,155,40
    sum(case when A.size_cd='41' and A.size_tp='40' then sale_qty
             else 0 end) as sale_qty_155,    -- 
    max(case when A.size_cd='41' and A.size_tp='40' then tot_in_qty
             else 0 end) as tot_in_qty_155,

  -- 43,170,40
    sum(case when A.size_cd='43' and A.size_tp='40' then sale_qty
             else 0 end) as sale_qty_170,    -- 
    max(case when A.size_cd='43' and A.size_tp='40' then tot_in_qty
             else 0 end) as tot_in_qty_170,

  -- 55,15-16,50
    sum(case when A.size_cd='55' and A.size_tp='50' then sale_qty
             else 0 end) as sale_qty_15_16,
    max(case when A.size_cd='55' and A.size_tp='50' then tot_in_qty
             else 0 end) as tot_in_qty_15_16,

    -- 56,17-18,50
    sum(case when A.size_cd='56' and A.size_tp='50' then sale_qty
             else 0 end) as sale_qty_17_18,
    max(case when A.size_cd='56' and A.size_tp='50' then tot_in_qty
             else 0 end) as tot_in_qty_17_18,

-- 60,40,60
    sum(case when A.size_cd='60' and A.size_tp='60' then sale_qty
             else 0 end) as sale_qty_40,
    max(case when A.size_cd='60' and A.size_tp='60' then tot_in_qty
             else 0 end) as tot_in_qty_40,

-- 61,42,60
    sum(case when A.size_cd='61' and A.size_tp='60' then sale_qty
             else 0 end) as sale_qty_42,
    max(case when A.size_cd='61' and A.size_tp='60' then tot_in_qty
             else 0 end) as tot_in_qty_42,

  -- 62,44,60
    sum(case when A.size_cd='62' and A.size_tp='60' then sale_qty
             else 0 end) as sale_qty_44,
    max(case when A.size_cd='62' and A.size_tp='60' then tot_in_qty
             else 0 end) as tot_in_qty_44,

  -- 67,54,60
    sum(case when A.size_cd='67' and A.size_tp='60' then sale_qty
             else 0 end) as sale_qty_54,
    max(case when A.size_cd='67' and A.size_tp='60' then tot_in_qty
             else 0 end) as tot_in_qty_54,

  -- 71,S,70
    sum(case when A.size_cd='71' and A.size_tp='70' then sale_qty
             else 0 end) as sale_qty_S,
    max(case when A.size_cd='71' and A.size_tp='70' then tot_in_qty
             else 0 end) as tot_in_qty_S,

  -- 74,XL,70
    sum(case when A.size_cd='74' and A.size_tp='70' then sale_qty
             else 0 end) as sale_qty_XL,
    max(case when A.size_cd='74' and A.size_tp='70' then tot_in_qty
             else 0 end) as tot_in_qty_XL,

--   82,6M,80
    sum(case when A.size_cd='82' and A.size_tp='80' then sale_qty
             else 0 end) as sale_qty_6M,
    max(case when A.size_cd='82' and A.size_tp='80' then tot_in_qty
             else 0 end) as tot_in_qty_6M,

  -- 83,12M,80
    sum(case when A.size_cd='83' and A.size_tp='80' then sale_qty
             else 0 end) as sale_qty_12M,
    max(case when A.size_cd='83' and A.size_tp='80' then tot_in_qty
             else 0 end) as tot_in_qty_12M,

  -- 84,18M,80
    sum(case when A.size_cd='84' and A.size_tp='80' then sale_qty
             else 0 end) as sale_qty_18M,
    max(case when A.size_cd='84' and A.size_tp='80' then tot_in_qty
             else 0 end) as tot_in_qty_18M,

    -- 85,24M,80
    sum(case when A.size_cd='85' and A.size_tp='80' then sale_qty
             else 0 end) as sale_qty_24M,
    max(case when A.size_cd='85' and A.size_tp='80' then tot_in_qty
             else 0 end) as tot_in_qty_24M,




  

  -- 위 새로 추가 -------



  
  
    -- 10,60,10
    sum(case when A.size_cd='10' and A.size_tp='10' then sale_qty
             else 0 end) as sale_qty_60,    -- 60
    max(case when A.size_cd='10' and A.size_tp='10' then tot_in_qty
             else 0 end) as tot_in_qty_60,

    -- 13,75,10
    -- 13,75,11
    -- 13,75,22
    sum(case when A.size_cd='13' and A.size_tp='10' then sale_qty
             when A.size_cd='13' and A.size_tp='11' then sale_qty
             when A.size_cd='13' and A.size_tp='22' then sale_qty
             else 0 end) as sale_qty_75,
    max(case when A.size_cd='13' and A.size_tp='10' then tot_in_qty
             when A.size_cd='13' and A.size_tp='11' then tot_in_qty
             when A.size_cd='13' and A.size_tp='22' then tot_in_qty
             else 0 end) as tot_in_qty_75,

    -- 14,80,10
    -- 14,80,11
    -- 14,80,22
    sum(case when A.size_cd='14' and A.size_tp='10' then sale_qty
             when A.size_cd='14' and A.size_tp='11' then sale_qty
             when A.size_cd='14' and A.size_tp='22' then sale_qty
             else 0 end) as sale_qty_80,
    max(case when A.size_cd='14' and A.size_tp='10' then tot_in_qty
             when A.size_cd='14' and A.size_tp='11' then tot_in_qty
             when A.size_cd='14' and A.size_tp='22' then tot_in_qty
             else 0 end) as tot_in_qty_80,

    -- 16,90,10
    -- 16,90,11
    -- 16,90,22
    sum(case when A.size_cd='16' and A.size_tp='10' then sale_qty
             when A.size_cd='16' and A.size_tp='11' then sale_qty
             when A.size_cd='16' and A.size_tp='22' then sale_qty
             else 0 end) as sale_qty_90,
    max(case when A.size_cd='16' and A.size_tp='10' then tot_in_qty
             when A.size_cd='16' and A.size_tp='11' then tot_in_qty
             when A.size_cd='16' and A.size_tp='22' then tot_in_qty
             else 0 end) as tot_in_qty_90,

    -- 20,100,10
    -- 20,100,11
    -- 20,100,20
    -- 20,100,22
   -- new -- 31,100,30
    sum(case when A.size_cd='20' and A.size_tp='10' then sale_qty
             when A.size_cd='20' and A.size_tp='11' then sale_qty
             when A.size_cd='20' and A.size_tp='20' then sale_qty
             when A.size_cd='20' and A.size_tp='22' then sale_qty
             when A.size_cd='31' and A.size_tp='30' then sale_qty
             else 0 end) as sale_qty_100,
    max(case when A.size_cd='20' and A.size_tp='10' then tot_in_qty
             when A.size_cd='20' and A.size_tp='11' then tot_in_qty
             when A.size_cd='20' and A.size_tp='20' then tot_in_qty
             when A.size_cd='20' and A.size_tp='22' then tot_in_qty
             when A.size_cd='31' and A.size_tp='30' then tot_in_qty
             else 0 end) as tot_in_qty_100,

    -- 21,110,10
    -- 21,110,11
    -- 21,110,20
    -- 21,110,22
    -- new -- 32,110,30
    sum(case when A.size_cd='21' and A.size_tp='10' then sale_qty
             when A.size_cd='21' and A.size_tp='11' then sale_qty
             when A.size_cd='21' and A.size_tp='20' then sale_qty
             when A.size_cd='21' and A.size_tp='22' then sale_qty
             when A.size_cd='32' and A.size_tp='30' then sale_qty
             else 0 end) as sale_qty_110,
    max(case when A.size_cd='21' and A.size_tp='10' then tot_in_qty
             when A.size_cd='21' and A.size_tp='11' then tot_in_qty
             when A.size_cd='21' and A.size_tp='20' then tot_in_qty
             when A.size_cd='21' and A.size_tp='22' then tot_in_qty
             when A.size_cd='32' and A.size_tp='30' then tot_in_qty
             else 0 end) as tot_in_qty_110,

    -- 22,120,11
    -- 22,120,20
    -- 22,120,22
    -- new -- 34,120,30
    sum(case when A.size_cd='22' and A.size_tp='11' then sale_qty
             when A.size_cd='22' and A.size_tp='20' then sale_qty
             when A.size_cd='22' and A.size_tp='22' then sale_qty
             when A.size_cd='34' and A.size_tp='30' then sale_qty
             else 0 end) as sale_qty_120,
    max(case when A.size_cd='22' and A.size_tp='11' then tot_in_qty
             when A.size_cd='22' and A.size_tp='20' then tot_in_qty
             when A.size_cd='22' and A.size_tp='22' then tot_in_qty
             when A.size_cd='34' and A.size_tp='30' then tot_in_qty
             else 0 end) as tot_in_qty_120,

    -- 33,115,30
    sum(case when A.size_cd='33' and A.size_tp='30' then sale_qty
             else 0 end) as sale_qty_115,
    max(case when A.size_cd='33' and A.size_tp='30' then tot_in_qty
             else 0 end) as tot_in_qty_115,

    -- 35,125,30
    sum(case when A.size_cd='35' and A.size_tp='30' then sale_qty
             else 0 end) as sale_qty_125,
    max(case when A.size_cd='35' and A.size_tp='30' then tot_in_qty
             else 0 end) as tot_in_qty_125,

    -- 36,130,30
    -- 36,130,40
    -- new -- 23,130,11
    sum(case when A.size_cd='36' and A.size_tp='30' then sale_qty
             when A.size_cd='36' and A.size_tp='40' then sale_qty
             when A.size_cd='23' and A.size_tp='11' then sale_qty
             else 0 end) as sale_qty_130,
    max(case when A.size_cd='36' and A.size_tp='30' then tot_in_qty
             when A.size_cd='36' and A.size_tp='40' then tot_in_qty
             when A.size_cd='23' and A.size_tp='11' then tot_in_qty
             else 0 end) as tot_in_qty_130,

    -- 37,135,30
    -- 37,135,40
    sum(case when A.size_cd='37' and A.size_tp='30' then sale_qty
             when A.size_cd='37' and A.size_tp='40' then sale_qty
             else 0 end) as sale_qty_135,
    max(case when A.size_cd='37' and A.size_tp='30' then tot_in_qty
             when A.size_cd='37' and A.size_tp='40' then tot_in_qty
             else 0 end) as tot_in_qty_135,

    -- 38,140,30
    -- 38,140,40
    -- new -- 24,140,11
    sum(case when A.size_cd='38' and A.size_tp='30' then sale_qty
             when A.size_cd='38' and A.size_tp='40' then sale_qty
             when A.size_cd='24' and A.size_tp='11' then sale_qty
             else 0 end) as sale_qty_140,
    max(case when A.size_cd='38' and A.size_tp='30' then tot_in_qty
             when A.size_cd='38' and A.size_tp='40' then tot_in_qty
             when A.size_cd='24' and A.size_tp='11' then tot_in_qty
             else 0 end) as tot_in_qty_140,

    -- 40,150,30
    -- 40,150,40
    sum(case when A.size_cd='40' and A.size_tp='30' then sale_qty
             when A.size_cd='40' and A.size_tp='40' then sale_qty
             else 0 end) as sale_qty_150,
    max(case when A.size_cd='40' and A.size_tp='30' then tot_in_qty
             when A.size_cd='40' and A.size_tp='40' then tot_in_qty
             else 0 end) as tot_in_qty_150,

    -- 42,160,40
    sum(case when A.size_cd='42' and A.size_tp='40' then sale_qty
             else 0 end) as sale_qty_160,
    max(case when A.size_cd='42' and A.size_tp='40' then tot_in_qty
             else 0 end) as tot_in_qty_160,

    -- 51,7-8,50
    sum(case when A.size_cd='51' and A.size_tp='50' then sale_qty
             else 0 end) as sale_qty_7_8,
    max(case when A.size_cd='51' and A.size_tp='50' then tot_in_qty
             else 0 end) as tot_in_qty_7_8,

    -- 52,9-10,50
    sum(case when A.size_cd='52' and A.size_tp='50' then sale_qty
             else 0 end) as sale_qty_9_10,
    max(case when A.size_cd='52' and A.size_tp='50' then tot_in_qty
             else 0 end) as tot_in_qty_9_10,

    -- 53,11-12,50
    sum(case when A.size_cd='53' and A.size_tp='50' then sale_qty
             else 0 end) as sale_qty_11_12,
    max(case when A.size_cd='53' and A.size_tp='50' then tot_in_qty
             else 0 end) as tot_in_qty_11_12,

    -- 54,13-14,50
    sum(case when A.size_cd='54' and A.size_tp='50' then sale_qty
             else 0 end) as sale_qty_13_14,
    max(case when A.size_cd='54' and A.size_tp='50' then tot_in_qty
             else 0 end) as tot_in_qty_13_14,

    -- 63,46,60
    sum(case when A.size_cd='63' and A.size_tp='60' then sale_qty
             else 0 end) as sale_qty_46,
    max(case when A.size_cd='63' and A.size_tp='60' then tot_in_qty
             else 0 end) as tot_in_qty_46,

    -- 64,48,60
    sum(case when A.size_cd='64' and A.size_tp='60' then sale_qty
             else 0 end) as sale_qty_48,
    max(case when A.size_cd='64' and A.size_tp='60' then tot_in_qty
             else 0 end) as tot_in_qty_48,

    -- 65,50,60
    sum(case when A.size_cd='65' and A.size_tp='60' then sale_qty
             else 0 end) as sale_qty_50,
    max(case when A.size_cd='65' and A.size_tp='60' then tot_in_qty
             else 0 end) as tot_in_qty_50,

    -- 66,52,60
    sum(case when A.size_cd='66' and A.size_tp='60' then sale_qty
             else 0 end) as sale_qty_52,
    max(case when A.size_cd='66' and A.size_tp='60' then tot_in_qty
             else 0 end) as tot_in_qty_52,

    -- 72,M,70
    -- new -- 02,M,25
    -- new -- 92,M,24
    sum(case when A.size_cd='72' and A.size_tp='70' then sale_qty
             when A.size_cd='02' and A.size_tp='25' then sale_qty
             when A.size_cd='92' and A.size_tp='24' then sale_qty
             else 0 end) as sale_qty_M,
    max(case when A.size_cd='72' and A.size_tp='70' then tot_in_qty
             when A.size_cd='02' and A.size_tp='25' then tot_in_qty
             when A.size_cd='92' and A.size_tp='24' then tot_in_qty
             else 0 end) as tot_in_qty_M,

    -- 73,L,70
    -- new -- 03,L,25
    -- new -- 93,L,24
    sum(case when A.size_cd='73' and A.size_tp='70' then sale_qty
             when A.size_cd='03' and A.size_tp='25' then sale_qty
             when A.size_cd='93' and A.size_tp='24' then sale_qty
             else 0 end) as sale_qty_L,
    max(case when A.size_cd='73' and A.size_tp='70' then tot_in_qty
             when A.size_cd='03' and A.size_tp='25' then tot_in_qty
             when A.size_cd='93' and A.size_tp='24' then tot_in_qty
             else 0 end) as tot_in_qty_L


    from agabang_dw.daily_data_by_size as A
    JOIN agabang_dw.prod_sales_stock_by_size as B
      on A.sty_cd = B.sty_cd
      and A.col_cd = B.col_cd
      and A.size_cd = B.size_cd
    WHERE A.sale_dt >= start_date and A.sale_dt <= end_date
      and A.br_cd in brand_code
      and substring(A.sty_cd, 5, 1) != '9'
      and substring(A.sty_cd, 3, 2) = sel_sesn_cd
    group by 1,2,3
),
SALE_GB_DATA as (
    select
        sty_cd,
        col_cd,
        sum(case when sale_gb = '온라인판매' then sales_qty else 0 end) as online_sale_qty,
        sum(case when sale_gb = '매장판매' then sales_qty else 0 end) as offline_sale_qty,
        sum(sales_qty) as total_sale_qty
    from agabang_dw.daily_shop_sales_by_color as A
    where A.sale_dt >= start_date and A.sale_dt <= end_date
      and A.br_cd in brand_code
      and substring(A.sty_cd, 5, 1) != '9'
      and substring(A.sty_cd, 3, 2) = sel_sesn_cd
    group by 1,2
),
SALE_BASE as (
  SELECT sty_cd,
          col_cd,
          shop_cd,
          SUM(sales_qty) AS shop_sales_qty
      FROM agabang_dw.daily_shop_sales_by_color as A
      WHERE A.br_cd in brand_code
        and substring(A.sty_cd, 3, 2) = sel_sesn_cd
        and substring(A.sty_cd, 5, 1) != '9'
        and A.sale_dt >= start_date and A.sale_dt <= end_date

      GROUP BY 1, 2, 3
),
SHOP_ENTROPY as (
  SELECT
        sty_cd,
        col_cd,
        round(entropy(shop_sales_qty),2) as entropy
    FROM SALE_BASE as T
    group by 1,2
),
SHOP_GINI AS (
  SELECT
        sty_cd,
        col_cd,
        ROUND(
            1 - 2 * SUM( (rank - 0.5) * shop_sales_ratio ) / COUNT(), 4
        ) AS gini
    FROM (
        SELECT
            sty_cd,
            col_cd,
            shop_cd,
            shop_sales_qty,
            shop_sales_qty / SUM(shop_sales_qty) OVER (PARTITION BY sty_cd, col_cd) AS shop_sales_ratio,
            ROW_NUMBER() OVER (PARTITION BY sty_cd, col_cd ORDER BY shop_sales_qty DESC) AS rank
        FROM SALE_BASE AS T1
    ) AS T2
    GROUP BY sty_cd, col_cd
),
filtered_data as(
        SELECT * FROM agabang_dw.prod_sales_stock_by_color as A
        WHERE A.br_cd in brand_code and substring(sty_cd, 5, 1) != '9' and substring(A.sty_cd, 3, 2) = sel_sesn_cd
    )

SELECT
    A.sty_cd AS sty_cd,
    A.sty_nm AS sty_nm,
    A.col_cd AS col_cd,
    A.col_nm AS col_nm,
    H.cod_year_season as year_season,
    -- coalesce(E.cat_nm, '미분류') as cat_nm,
    coalesce(H.large_cat, H.it_gb_nm) as cat_nm,
    case
      when {{sel_category.value}} = 19 then '전체'
      else coalesce(H.item_raw_nm, H.item_nm)  -- 실제 복종명 사용 (원피스, 바지 등)
    end as item_nm,
    A.tot_in_qty AS tot_in_qty,
    B.sale_qty_tot AS tot_sale_qty,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_tot / A.tot_in_qty, 2) ELSE NULL END AS sale_per_tot,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_3m / B.tot_in_qty_3m, 2) ELSE NULL END AS sale_per_3m,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_6m / B.tot_in_qty_6m, 2) ELSE NULL END AS sale_per_6m,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_12m / B.tot_in_qty_12m, 2) ELSE NULL END AS sale_per_12m,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_18m / B.tot_in_qty_18m, 2) ELSE NULL END AS sale_per_18m,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_2y / B.tot_in_qty_2y, 2) ELSE NULL END AS sale_per_2y,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_3y / B.tot_in_qty_3y, 2) ELSE NULL END AS sale_per_3y,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_4y / B.tot_in_qty_4y, 2) ELSE NULL END AS sale_per_4y,

  -- new start -----
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_01 / B.tot_in_qty_01, 2) ELSE NULL END AS sale_per_01,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_03 / B.tot_in_qty_03, 2) ELSE NULL END AS sale_per_03,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_newborn / B.tot_in_qty_newborn, 2) ELSE NULL END AS sale_per_newborn,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_free / B.tot_in_qty_free, 2) ELSE NULL END AS sale_per_free,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_100X120 / B.tot_in_qty_100X120, 2) ELSE NULL END AS sale_per_100X120,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_100X130 / B.tot_in_qty_100X130, 2) ELSE NULL END AS sale_per_100X130,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_83X83 / B.tot_in_qty_83X83, 2) ELSE NULL END AS sale_per_83X83,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_85X85 / B.tot_in_qty_85X85, 2) ELSE NULL END AS sale_per_85X85,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_95X95 / B.tot_in_qty_95X95, 2) ELSE NULL END AS sale_per_95X95,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_105X135 / B.tot_in_qty_105X135, 2) ELSE NULL END AS sale_per_105X135,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_115X145 / B.tot_in_qty_115X145, 2) ELSE NULL END AS sale_per_115X145,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_mini / B.tot_in_qty_mini, 2) ELSE NULL END AS sale_per_mini,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_general / B.tot_in_qty_general, 2) ELSE NULL END AS sale_per_general,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_seven / B.tot_in_qty_seven, 2) ELSE NULL END AS sale_per_seven,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_65 / B.tot_in_qty_65, 2) ELSE NULL END AS sale_per_65,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_70 / B.tot_in_qty_70, 2) ELSE NULL END AS sale_per_70,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_85 / B.tot_in_qty_85, 2) ELSE NULL END AS sale_per_85,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_95 / B.tot_in_qty_95, 2) ELSE NULL END AS sale_per_95,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_145 / B.tot_in_qty_145, 2) ELSE NULL END AS sale_per_145,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_155 / B.tot_in_qty_155, 2) ELSE NULL END AS sale_per_155,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_170 / B.tot_in_qty_170, 2) ELSE NULL END AS sale_per_170,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_15_16 / B.tot_in_qty_15_16, 2) ELSE NULL END AS sale_per_15_16,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_17_18 / B.tot_in_qty_17_18, 2) ELSE NULL END AS sale_per_17_18,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_40 / B.tot_in_qty_40, 2) ELSE NULL END AS sale_per_40,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_42 / B.tot_in_qty_42, 2) ELSE NULL END AS sale_per_42,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_44 / B.tot_in_qty_44, 2) ELSE NULL END AS sale_per_44,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_54 / B.tot_in_qty_54, 2) ELSE NULL END AS sale_per_54,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_S / B.tot_in_qty_S, 2) ELSE NULL END AS sale_per_S,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_XL / B.tot_in_qty_XL, 2) ELSE NULL END AS sale_per_XL,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_6M / B.tot_in_qty_6M, 2) ELSE NULL END AS sale_per_6M,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_12M / B.tot_in_qty_12M, 2) ELSE NULL END AS sale_per_12M,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_18M / B.tot_in_qty_18M, 2) ELSE NULL END AS sale_per_18M,
  CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_24M / B.tot_in_qty_24M, 2) ELSE NULL END AS sale_per_24M,
  
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_60 / B.tot_in_qty_60, 2) ELSE NULL END AS sale_per_60,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_75 / B.tot_in_qty_75, 2) ELSE NULL END AS sale_per_75,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_80 / B.tot_in_qty_80, 2) ELSE NULL END AS sale_per_80,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_90 / B.tot_in_qty_90, 2) ELSE NULL END AS sale_per_90,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_100 / B.tot_in_qty_100, 2) ELSE NULL END AS sale_per_100,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_110 / B.tot_in_qty_110, 2) ELSE NULL END AS sale_per_110,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_120 / B.tot_in_qty_120, 2) ELSE NULL END AS sale_per_120,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_115 / B.tot_in_qty_115, 2) ELSE NULL END AS sale_per_115,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_125 / B.tot_in_qty_125, 2) ELSE NULL END AS sale_per_125,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_130 / B.tot_in_qty_130, 2) ELSE NULL END AS sale_per_130,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_135 / B.tot_in_qty_135, 2) ELSE NULL END AS sale_per_135,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_140 / B.tot_in_qty_140, 2) ELSE NULL END AS sale_per_140,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_150 / B.tot_in_qty_150, 2) ELSE NULL END AS sale_per_150,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_160 / B.tot_in_qty_160, 2) ELSE NULL END AS sale_per_160,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_7_8 / B.tot_in_qty_7_8, 2) ELSE NULL END AS sale_per_7_8,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_9_10 / B.tot_in_qty_9_10, 2) ELSE NULL END AS sale_per_9_10,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_11_12 / B.tot_in_qty_11_12, 2) ELSE NULL END AS sale_per_11_12,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_13_14 / B.tot_in_qty_13_14, 2) ELSE NULL END AS sale_per_13_14,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_46 / B.tot_in_qty_46, 2) ELSE NULL END AS sale_per_46,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_48 / B.tot_in_qty_48, 2) ELSE NULL END AS sale_per_48,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_50 / B.tot_in_qty_50, 2) ELSE NULL END AS sale_per_50,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_52 / B.tot_in_qty_52, 2) ELSE NULL END AS sale_per_52,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_M / B.tot_in_qty_M, 2) ELSE NULL END AS sale_per_M,
    CASE WHEN A.tot_in_qty > 0 THEN ROUND(B.sale_qty_L / B.tot_in_qty_L, 2) ELSE NULL END AS sale_per_L,

    A.tag_prce AS tag_prce,
    A.tot_in_tag_amt AS tot_in_tag_amt,
    A.tot_in_cost_amt AS tot_in_cost_amt,
    B.sale_amt_tot AS tot_sale_amt,
    B.sale_qty_tot * A.tag_prce AS tot_sale_tag,
    CASE WHEN A.tot_in_tag_amt > 0 THEN ROUND((B.sale_qty_tot*A.tag_prce) / A.tot_in_tag_amt, 2) ELSE NULL END AS sale_tag_per,
    CASE WHEN A.tot_in_cost_amt > 0 THEN ROUND(B.sale_amt_tot / A.tot_in_cost_amt, 2) ELSE NULL END AS sale_return_per,
    CASE WHEN GB.total_sale_qty > 0 THEN ROUND(GB.online_sale_qty / GB.total_sale_qty, 2) ELSE NULL END AS online_sale_per,
    SE.entropy as shop_entropy,
    SG.gini as shop_gini
FROM filtered_data AS A
JOIN SALE_DATA as B
    on A.sty_cd = B.sty_cd
    and A.col_cd = B.col_cd
JOIN agabang.plstycd as C
    ON A.sty_cd = C.sty_cd

JOIN agabang_dw.retooldb_code_season as G
    ON substring(A.sty_cd,3,2) = G.year_sesn_cd
JOIN STY_SEASON as H
    ON A.sty_cd = H.sty_cd
LEFT JOIN SALE_GB_DATA as GB
    ON A.sty_cd = GB.sty_cd
    AND A.col_cd = GB.col_cd
LEFT JOIN SHOP_ENTROPY as SE
    ON A.sty_cd = SE.sty_cd
    AND A.col_cd = SE.col_cd
LEFT JOIN SHOP_GINI as SG
    ON A.sty_cd = SG.sty_cd
    AND A.col_cd = SG.col_cd
WHERE
H.index = '{{ select_item_type.value }}' and
CASE when ({{sel_category.value ?? 0}} = 91) THEN H.item_md_category_id is null -- 복종X:91
     WHEN ({{sel_category.value ?? 0}} = 19) THEN true -- 전체:19
     when ({{sel_category.value ?? 0}} = 61) then substring(A.sty_cd,5,2) in ('61','81') -- 용품: 발육
     when ({{sel_category.value ?? 0}} = 62) then substring(A.sty_cd,5,2) in ('62','82') -- 용품: 발육
     when ({{sel_category.value ?? 0}} = 63) then substring(A.sty_cd,5,2) in ('63','83') -- 용품: 발육
     when ({{sel_category.value ?? 0}} = 64) then substring(A.sty_cd,5,2) in ('64','84') -- 용품: 발육
     when ({{sel_category.value ?? 0}} = 65) then substring(A.sty_cd,5,2) in ('65','85') -- 용품: 발육
     when ({{sel_category.value ?? 0}} = 66) then substring(A.sty_cd,5,2) in ('66','86') -- 용품: 발육
     when ({{sel_category.value ?? 0}} = 68) then substring(A.sty_cd,5,2) in ('68','88') -- 용품: 발육
     ELSE {{sel_category.value ?? 0}} = CAST(COALESCE(H.item_md_category_id, '0') as int) END
AND concat(C.sty_nm,' ',A.sty_cd,' ',H.fabric,' ',B.col_nm) like '%{{ search_text.value }}%'
ORDER BY sale_per_tot desc, tot_sale_qty desc;