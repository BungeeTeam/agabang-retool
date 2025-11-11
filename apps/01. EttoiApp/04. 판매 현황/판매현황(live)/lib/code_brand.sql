SELECT
distinct
br_cd,
br_nm,
sub_br_cd,
coalesce(sub_br_nm, '에뜨와') as sub_br_nm
FROM agabang_dw.dim_style
WHERE br_cd in ('07')