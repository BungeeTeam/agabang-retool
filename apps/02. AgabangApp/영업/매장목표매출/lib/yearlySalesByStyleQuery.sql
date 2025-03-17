WITH tbl as (
    SELECT
        A.sale_dt,
        A.br_cd,
        A.biz_cd,
        A.sub_br_cd,
        A.sub_br_nm,
        A.season_nm,
        A.season_cd,
        A.year_cd,
        A.year_nm,
        A.it,
        A.it_nm,
        A.it_gb,
        A.it_gb_nm,
        A.item,
        A.item_nm,
        A.onoff_flag,
        A.sales_price,
        CASE
            WHEN A.it = '8' THEN '용품'
            WHEN DATE_DIFF('day', B.season_first_out_df, A.sale_dt) <= 180 THEN '정상'
            ELSE '이월'
        END AS sales_type
    FROM (
        SELECT * 
        FROM agabang_dw.daily_shop_sales_by_dimension 
        WHERE date_format(sale_dt, '%m-%d') <= date_format(DATE '{{ yearlyDate.value }}', '%m-%d')
    ) AS A
    LEFT JOIN (
        SELECT year_cd,
            season_cd,
            MIN(first_out_dt) AS season_first_out_df
        FROM agabang_dw.dim_style
        WHERE first_out_dt IS NOT NULL
        GROUP BY year_cd, season_cd
    ) AS B
    ON A.year_cd = B.year_cd AND A.season_cd = B.season_cd
)
SELECT
  YEAR(sale_dt) as time_unit,
  sales_type,
  br_cd,
  biz_cd,
  sub_br_cd,
  sub_br_nm,
  season_nm,
  season_cd,
  year_cd,
  year_nm,
  it,
  it_nm,
  it_gb,
  it_gb_nm,
  item,
  item_nm,
  onoff_flag,
  SUM(sales_price) / 1000000  as rev
FROM tbl
GROUP BY
  YEAR(sale_dt), sales_type, br_cd, biz_cd, sub_br_cd, sub_br_nm,
  it, it_nm, it_gb, it_gb_nm, item, item_nm, onoff_flag,
  season_nm, season_cd, year_cd, year_nm
;
