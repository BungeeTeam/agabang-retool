SELECT DISTINCT
  CASE
    WHEN cat_nm IN ({{def_maternity_code_list.value.map(item => `'${item}'`).join(', ')}}) THEN '출산용품'
    ELSE cat_nm
  END AS cat_nm
FROM agabang_dw.retooldb_item_md_info
WHERE cat_nm NOT IN ('', '기타') 
  AND cat_nm IS NOT NULL
  AND br_cd='07'
ORDER BY cat_nm