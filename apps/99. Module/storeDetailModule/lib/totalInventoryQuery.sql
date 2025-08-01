WITH sales_tbl as (
  SELECT
    year_cd,
    year_nm,
    season_nm,
    season_cd,
    SUM(sales_qty) as sales_qty
  FROM agabang_dw.daily_shop_sales_by_dimension
  GROUP BY year_cd, year_nm, season_nm, season_cd
),
inventory_tbl as (
  SELECT year_cd, year_nm, season_nm, season_cd, SUM(out_qty) as out_qty
  FROM (
    SELECT 
      A.sty_cd as sty_cd, year_cd, year_nm, season_nm, season_cd, out_qty
    FROM (
      SELECT
        sty_cd,
        SUM(out_qty) as out_qty
      FROM agabang_dw.daily_shop_dsoutrtn_by_size
      GROUP BY sty_cd
    ) AS A
    LEFT JOIN (
      SELECT DISTINCT 
        sty_cd, year_cd, year_nm, season_nm, season_cd
      FROM agabang_dw.dim_style
    ) AS B
    ON A.sty_cd = B.sty_cd
  )
  GROUP BY year_cd, year_nm, season_nm, season_cd
)
SELECT 
  A.year_cd as year_cd,
  A.year_nm as year_nm,
  A.season_cd as season_cd,
  A.season_nm as season_nm,
  A.sales_qty as sales_qty,
  B.out_qty as in_qty,
  B.out_qty - A.sales_qty as inventory,
  A.sales_qty / B.out_qty as ratio
FROM sales_tbl as A
LEFT JOIN (
  SELECT * FROM inventory_tbl
) as B
ON A.year_cd = B.year_cd AND A.season_cd = B.season_cd
ORDER BY A.year_nm DESC, A.season_nm