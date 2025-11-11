SELECT *
FROM discontinued_products
WHERE is_discontinued = TRUE
  AND (
    -- var_brand_code가 '01'이고 select_brand가 'all'인 경우
    ('{{ var_brand_code.value }}' = '01' AND '{{ select_brand.value }}' = 'all' AND
     (sty_cd LIKE '01%' OR sty_cd LIKE '02%' OR sty_cd LIKE '58%' OR 
      sty_cd LIKE '71%' OR sty_cd LIKE '72%' OR sty_cd LIKE '73%' OR 
      sty_cd LIKE '74%' OR sty_cd LIKE '75%' OR sty_cd LIKE '76%' OR sty_cd LIKE '77%'))
    OR
    -- var_brand_code가 '01'이고 select_brand가 'agabang'인 경우  
    ('{{ var_brand_code.value }}' = '01' AND '{{ select_brand.value }}' = 'agabang' AND
     sty_cd LIKE '01%')
    OR
    -- var_brand_code가 '01'이고 select_brand가 'etc'인 경우
    ('{{ var_brand_code.value }}' = '01' AND '{{ select_brand.value }}' = 'etc' AND
     (sty_cd LIKE '02%' OR sty_cd LIKE '58%' OR sty_cd LIKE '71%' OR 
      sty_cd LIKE '72%' OR sty_cd LIKE '73%' OR sty_cd LIKE '74%' OR 
      sty_cd LIKE '75%' OR sty_cd LIKE '76%' OR sty_cd LIKE '77%'))
    OR
    -- var_brand_code가 '07'인 경우
    ('{{ var_brand_code.value }}' = '07' AND sty_cd LIKE '07%')
  );