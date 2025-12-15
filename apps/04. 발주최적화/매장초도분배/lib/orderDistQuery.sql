SELECT
  large_cat,
  middle_cat,
  small_cat,
  sty_cd,
  shop_cd,
  in_qty,
  sales_qty,
  ratio,
  segment,
  br_cd,
  year_cd,
  season_cd
FROM agabang_dw.f_initial_distribution 
WHERE season_cd = '{{ seasonSelect.value.slice(1, 2) }}' 
AND year_cd IN ('{{ getPreviousChar(seasonSelect.value.slice(0, 1)) }}')
AND br_cd = '{{ brcd.value }}'
AND large_cat = '{{ largeCatSelect.selectedLabel }}'
;