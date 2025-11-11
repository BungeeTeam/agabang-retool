SELECT DISTINCT
  p.size_tp as size_tp,
  p.size_cd as size_cd, 
  p.size_nm as size_nm,
  p.ord_seq as ord_seq
FROM agabang.plsizegrd AS p
-- JOIN agabang.plcoszcd AS pcs
--   ON p.br_cd = substring(pcs.sty_cd, 1, 2)
--   AND p.size_cd = pcs.size_cd
-- JOIN agabang_dw.retooldb_item_md_assort AS ima
--   ON pcs.sty_cd = substring(ima.sty_col_cd, 1, 9)
--   AND pcs.col_cd = substring(ima.sty_col_cd, 10, 2)
WHERE 
br_cd = '{{ var_brand_code.value }}'
  -- substring(ima.sty_col_cd, 1, 2) = '{{ var_brand_code.value }}'
  -- AND substring(ima.sty_col_cd, 3, 1) = substring('{{ select_season.value }}', 1, 1)
  -- AND substring(ima.sty_col_cd, 4, 1) = substring('{{ select_season.value }}', 2, 1)
  -- AND ima.final_check = TRUE
ORDER BY
  p.size_tp,
  p.ord_seq

-- 아래는 dim_style 버전인데 브랜드코드 07, 시즌 S1 등에서 부정확하여 미사용
-- SELECT DISTINCT
--   p.size_tp as size_tp,
--   p.size_cd as size_cd,
--   p.size_nm as size_nm,
--   p.ord_seq as ord_seq
-- FROM agabang.plsizegrd AS p
-- JOIN agabang_dw.dim_style AS ds
--   ON p.br_cd = ds.br_cd 
--   AND p.size_tp = ds.size_tp
--   AND p.size_cd = ds.size_cd
-- JOIN agabang_dw.retooldb_item_md_assort AS ima
--   ON concat(ds.sty_cd, ds.col_cd) = ima.sty_col_cd
-- WHERE p.br_cd = '{{ var_brand_code.value }}'
--   AND ds.year_cd = substring('{{ select_season.value }}', 1, 1)
--   AND ds.season_cd = substring('{{ select_season.value }}', 2, 1)
--   AND ima.final_check = TRUE
-- ORDER BY p.size_tp, p.ord_seq