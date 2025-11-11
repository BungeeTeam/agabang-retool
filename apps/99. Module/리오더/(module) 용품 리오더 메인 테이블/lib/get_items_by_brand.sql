SELECT item, max(item_nm) as item_nm
FROM agabang_dw.dim_style S
  WHERE S.it IN (6, 8)
    AND (
      ('{{ var_brand_code.value }}' = '01'
        AND COALESCE(S.sub_br_nm, '') != '스토케'
        AND
        (
          ('{{ select_brand.value }}' = 'all' AND (
            S.br_cd in ('01', '02', '58', '71', '72', '73', '74', '75', '76', '77')
          ))
          OR
          ('{{ select_brand.value }}' = 'agabang' AND (
            S.br_cd in ('01')
          ))
          OR
          ('{{ select_brand.value }}' = 'etc' AND  
            S.br_cd in ('02', '58', '71', '72', '73', '74', '75', '76', '77')
          )
        )
      )
    OR
      ('{{ var_brand_code.value }}' = '07'
      AND substring(S.sty_cd, 3, 1) >= 'M'
      AND ( -- '07' 브랜드 조건 내의 OR 그룹 시작
        S.br_cd = '07'  AND
        ( -- '07' 브랜드 세부 조건 OR 그룹 시작
          '{{ select_brand.value }}' = 'all' OR
          ('{{ select_brand.value }}' = 'liewood' AND (
            S.sty_nm LIKE '%리우드%' OR
            S.sty_nm LIKE '%오비디자인스%' OR
            S.sty_nm LIKE '%노바디노즈%'
          )) OR
          ('{{ select_brand.value }}' = 'ettoi' AND
            S.sty_nm NOT LIKE '%리우드%' AND
            S.sty_nm NOT LIKE '%오비디자인스%' AND
            S.sty_nm NOT LIKE '%노바디노즈%'
          )
        ) -- '07' 브랜드 세부 조건 OR 그룹 끝
      )) -- '07' 브랜드 조건 내의 OR 그룹 끝
    OR
      ('{{ var_brand_code.value }}' = '79'
      AND ( -- '79' 브랜드 조건 내의 OR 그룹 시작
        ('{{ select_brand.value }}' = 'all'
            AND S.br_cd = '79') OR
        ('{{ select_brand.value }}' = 'disney'
            AND S.br_cd = '79')
      )) -- '79' 브랜드 조건 내의 OR 그룹 끝
    ) -- 최상위 괄호 끝
GROUP BY item
ORDER BY item, item_nm
