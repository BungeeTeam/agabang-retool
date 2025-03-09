SELECT
  sales_year,
  sales_q,
  SUM(sales_price) as "판매금액"
FROM (SELECT
    shop_cd,  
    sales_price,
    year(sale_dt) as sales_year,
    toQuarter(sale_dt) as sales_q
  FROM agabang_dw.daily_shop_sales_by_size
  WHERE shop_cd = '{{ selectedRow.value.shop_cd }}'
  AND YEAR(sale_dt) > YEAR(today()) - 3
)
GROUP BY sales_year, sales_q, shop_cd
ORDER BY sales_year DESC, sales_q
;