WITH tbl AS (
  SELECT 
    *,
    B.br_cd as br_cd,
    YEAR(sale_dt) as "연도",
    IF(tag_price = unit_price, '정상(N)', '할인(D)') AS "정상구분"
  FROM (
    SELECT
      *,
      sales_price / sales_qty as unit_price,
      year(sale_dt) as sales_year
    FROM agabang_dw.daily_shop_sales_by_size
    WHERE shop_cd = '{{ selectedRow.value.shop_cd }}' 
    AND YEAR(sale_dt) > YEAR(today()) - 3
  ) AS A
  LEFT JOIN (
    SELECT 
      sty_cd, br_cd, it_nm as cat_nm, tag_price
    FROM agabang_dw.dim_style
  ) AS B
  ON A.sty_cd = B.sty_cd
)
SELECT 
  "연도", 
  "정상구분", 
  COALESCE(cat_nm, '미분류') as "카테고리",
  shop_cd, 
  shop_nm,
  br_cd,
  sum(sales_price) as "매출"
FROM tbl
GROUP BY "연도", "정상구분", br_cd, cat_nm, shop_cd, shop_nm
;