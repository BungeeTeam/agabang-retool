select
  A.reorder_sty_cd,
  B.sty_nm as reorder_sty_nm,
  A.sty_cd as sty_cd,
  C.sty_nm as sty_nm
from agabang_dw.retooldb_item_reorder_match as A 
LEFT JOIN agabang.plstycd as B
  ON A.reorder_sty_cd = B.sty_cd
LEFT JOIN agabang.plstycd as C
  ON A.sty_cd = C.sty_cd
where substring(B.sty_cd, 1, 2) = '{{brand_code.value}}'