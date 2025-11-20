select
  it,
  large_cat, 
  it_gb,
  middle_cat, 
  item,
  small_cat,
  t1.sty_cd as sty_cd, 
  sty_nm,
  t1.col_cd as col_cd, 
  col_nm,
  t1.size_cd as size_cd, 
  size_nm,
  plan_qty,
  plan_dt,
  sty_codes as related_items
from (
  select
    sty_cd, 
    col_cd, 
    size_cd, 
    in_dt as plan_dt, 
    sum(in_qty) as plan_qty
  from agabang.dsin
  where substr(sty_cd, 1, 2) = '{{ brcd2.value }}' 
    and substr(sty_cd, 3, 2) = '{{ seasonSelect2.value || "-" }}'
    and io_type = 'I'
    and wh_cd = '1000'
    group by sty_cd, col_cd, size_cd, in_dt
) as t1
left join (
  select 
  distinct 
    it,
    it_nm as large_cat,
    it_gb,
    it_gb_nm as middle_cat, 
    item,
    item_nm as small_cat,
    sty_cd, 
    col_cd, 
    size_cd, 
    sty_nm, 
    col_nm, 
    size_nm 
  from agabang_dw.dim_style
  where substr(sty_cd, 3, 2) = '{{ seasonSelect2.value || "-" }}' 
) t2
on t1.sty_cd = t2.sty_cd and t1.col_cd = t2.col_cd and t1.size_cd = t2.size_cd
left join (
  SELECT
    sty_col_cd,
    related_items,
    arrayFilter(x -> x != '', [
        extract(related_items, '"sty_cd"\\s*:\\s*"([^"]+)"'),
        extract(substring(related_items, position(related_items, '"sty_cd"') + 8), '"sty_cd"\\s*:\\s*"([^"]+)"'),
        extract(substring(related_items, position(related_items, '"sty_cd"', position(related_items, '"sty_cd"') + 8) + 8), '"sty_cd"\\s*:\\s*"([^"]+)"')
    ]) AS sty_codes
  FROM agabang_dw.retooldb_item_md_assort
  WHERE related_items != '{}'
    AND related_items IS NOT NULL
    AND match(related_items, '"sty_cd"')
) t3
on concat(t1.sty_cd, t1.col_cd) = t3.sty_col_cd
order by large_cat, middle_cat, small_cat, sty_cd, col_cd, size_cd