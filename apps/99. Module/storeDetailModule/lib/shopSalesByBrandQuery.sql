WITH tbl AS (
  SELECT 
    *,
    YEAR(sale_dt) as "연도",
    IF(tag_price = unit_price, '정상', '할인') AS "정상구분",
    CASE
      WHEN tag_price = unit_price THEN '0%(정상)'
      WHEN unit_price >= tag_price * 0.9 THEN '10%'
      WHEN unit_price >= tag_price * 0.8 THEN '20%'
      WHEN unit_price >= tag_price * 0.7 THEN '30%'
      WHEN unit_price >= tag_price * 0.6 THEN '40%'
      WHEN unit_price >= tag_price * 0.5 THEN '50%'
      WHEN unit_price >= tag_price * 0.4 THEN '60%'
      WHEN unit_price >= tag_price * 0.3 THEN '70%'
      WHEN unit_price >= tag_price * 0.2 THEN '80%'
    ELSE '균일'
    END AS "할인구분"
  FROM (
    SELECT
      *,
      sales_price / sales_qty as unit_price,
      year(sale_dt) as sales_year
    FROM agabang_dw.daily_shop_sales_by_dimension
    WHERE shop_cd = '{{ selectedRow.value.shop_cd }}' 
    AND date_format(DATE '{{ startDate.value }}', '%m-%d') <= date_format(sale_dt, '%m-%d') AND date_format(sale_dt, '%m-%d') <= date_format(DATE '{{ endDate.value }}', '%m-%d')
  ) AS A
  LEFT JOIN (
    SELECT
      DISTINCT
        sty_cd, 
        br_cd, 
        CASE 
          WHEN it_gb IN ('68', '88') THEN it_gb_nm
          ELSE second_lv_class
        END AS cat_nm, 
        tag_price
    FROM agabang_dw.dim_style
  ) AS B
  ON A.sty_cd = B.sty_cd
)
SELECT 
  "연도", 
  "정상구분", 
  "할인구분",
  COALESCE(cat_nm, '미분류') as "카테고리",
  shop_cd, 
  shop_nm,
  br_cd,
  ROUND(sum(sales_price) / 1000, 0) as "매출"
FROM tbl
GROUP BY "연도", "정상구분", "할인구분", br_cd, cat_nm, shop_cd, shop_nm
;