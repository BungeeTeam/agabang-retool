SELECT
br_cd,
CASE 
  WHEN br_cd = '75' THEN '해외브랜드'
  WHEN br_cd = '76' THEN '더블하트/스와들업'
  ELSE br_nm END as br_nm
FROM agabang.plbrcd
WHERE br_cd in ('79')