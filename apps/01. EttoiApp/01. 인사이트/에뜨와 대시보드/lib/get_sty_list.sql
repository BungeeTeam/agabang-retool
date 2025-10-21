
SELECT
  A.sty_cd as sty_cd,
  A.sty_nm as sty_nm
FROM agabang_dw.retooldb_item_md_info as A
where A.br_cd='07'
order by 2 asc