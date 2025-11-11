WITH base AS (
  SELECT *,
         COALESCE(updt_dt, regi_dt) AS dt
  FROM agabang.prdeliverystock
  WHERE SUBSTRING(sty_cd, 1, 2) = '{{ var_brand_code.value }}' -- 브랜드코드
),
max_dt AS (
  SELECT MAX(dt) AS latest_dt FROM base
)
SELECT
    comp_cd,
    upload_dt,
    sty_cd,
    col_cd,
    size_cd,
    stck_qty,
    rmrk,
    prog_id,
    regi_id,
    regi_dt,
    updt_id,
    updt_dt
FROM base b
JOIN max_dt m ON b.dt = m.latest_dt
ORDER BY sty_cd, col_cd, size_cd;