with 
  ({{ yongpum_brand_code.value }}) as brand_code
    
SELECT
br_cd,
br_nm
FROM agabang.plbrcd
WHERE br_cd in brand_code