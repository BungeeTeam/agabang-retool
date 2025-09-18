SELECT
    A.shop_cd,
    A.shop_nm,
    A.open_dt,
    A.biz_nm,
    A.br_nm,
    C.sub_br_nm,
    A.gb_nm,
    A.tp_nm,
    A.area_nm,
    B.team_nm,
    B.user_nm
FROM (
    SELECT
      shop_cd,
      shop_nm,
      open_dt,
      array_agg(distinct biz_nm) as biz_nm,
      array_agg(distinct br_nm) as br_nm,
      max(gb_nm) as gb_nm,
      max(tp_nm) as tp_nm,
      max(area_nm) as area_nm
    FROM agabang_dw.dim_shop
    WHERE shop_cd = '{{ selectedRow.value.shop_cd }}'
    GROUP BY shop_cd, shop_nm, open_dt
) AS A
LEFT JOIN (
    SELECT DISTINCT shop_cd, team_nm, user_nm
    FROM (
        SELECT *, max(updt_dt) OVER (PARTITION BY shop_cd) as max_updt_dt
        FROM agabang_dw.dim_shop
    )
    WHERE updt_dt = max_updt_dt and shop_cd = '{{ selectedRow.value.shop_cd }}'
) AS B
ON A.shop_cd = B.shop_cd
LEFT JOIN (
    SELECT shop_cd, array_agg(distinct sub_br_nm) as sub_br_nm
    FROM agabang_dw.daily_shop_sales_by_dimension
    WHERE shop_cd = '{{ selectedRow.value.shop_cd }}' AND sale_dt >= '{{ moment().startOf("year").format("YYYY-MM-DD") }}' AND sub_br_cd != 'etc'
    GROUP BY shop_cd
) AS C
ON A.shop_cd = C.shop_cd;  
;