WITH tbl as (
SELECT 
  coalesce(time_unit, toYear(year_month)) as time_unit,
  coalesce(ym, date_format(year_month, '%y-%m')) as ym,
  coalesce(shop_cd, B.shop_cd) as shop_cd,
  coalesce(br_cd, B.br_cd) as br_cd,
  coalesce(biz_cd, B.biz_cd) as biz_cd,
  coalesce(biz_nm, B.biz_nm) as biz_nm,
  coalesce(onoff_flag, B.onoff_flag) as onoff_flag,
  coalesce(tp_nm, B.tp_nm) as tp_nm,
  coalesce(tp_cd, B.tp_cd) as tp_cd,
  *
FROM (
  SELECT
    YEAR(sale_dt) as time_unit, 
    date_format(sale_dt, '%y-%m') as ym,
    shop_cd, shop_nm, 
    biz_cd, biz_nm, 
    br_cd, br_nm, 
    tp_cd, tp_nm,
    team_cd, team_nm,
    user_cd, user_nm,
    area_cd, area_nm, onoff_flag,
    sum(sales_price) as rev
  FROM agabang_dw.daily_shop_sales_by_dimension
  WHERE date_format(sale_dt, '%m-%d') <= date_format(DATE '{{ yearlyDate.value }}', '%m-%d')
  GROUP BY 
    YEAR(sale_dt), date_format(sale_dt, '%y-%m'),
    shop_cd, shop_nm, 
    biz_cd, biz_nm,
    br_cd, br_nm,
    tp_cd, tp_nm,
    team_cd, team_nm,
    user_cd, user_nm,
    area_cd, area_nm, onoff_flag
) as A
FULL OUTER JOIN (
  SELECT 
    CASE
      WHEN br_cd = '01' THEN 'A1'
      WHEN br_cd = '07' THEN 'A4'
      WHEN br_cd = '71' THEN 'A1'
      WHEN br_cd = '79' THEN 'DS'
      ELSE 'A1'
    END as biz_cd,
    CASE
      WHEN br_cd = '01' THEN '아가방사업부'
      WHEN br_cd = '07' THEN '에뜨와사업부'
      WHEN br_cd = '71' THEN '아가방사업부'
      WHEN br_cd = '79' THEN '디즈니사업부'
      ELSE '아가방사업부'
    END as biz_nm,
    '오프라인' as onoff_flag,
    '기타' as tp_nm,
    '47' as tp_cd,
    br_cd, shop_cd, year_month, target_sales
  FROM agabang_dw.yearly_target_sales_by_shop
  WHERE date_format(year_month, '%m-%d') <= date_format(DATE '{{ yearlyDate.value }}', '%m-%d')
) as B
ON A.biz_cd = B.biz_cd AND A.br_cd = B.br_cd AND A.shop_cd = B.shop_cd AND A.ym = date_format(B.year_month, '%y-%m')
)
SELECT 
  time_unit, shop_cd, shop_nm, biz_cd, biz_nm,
  br_cd, br_nm,
  tp_cd, tp_nm, team_cd, team_nm,
  user_cd, user_nm, area_cd, area_nm, onoff_flag,
  SUM(rev) / 1000000 as rev, 
  SUM(target_sales) / 1000000 as target_sales
FROM tbl
GROUP BY time_unit, shop_cd, shop_nm, biz_cd, biz_nm,
  br_cd, br_nm,
  tp_cd, tp_nm, team_cd, team_nm,
  user_cd, user_nm, area_cd, area_nm, onoff_flag