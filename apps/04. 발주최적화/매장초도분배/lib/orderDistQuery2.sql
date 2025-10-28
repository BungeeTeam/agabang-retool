WITH extracted_sty_codes AS (
  SELECT 
    CASE WHEN related_items IN ('[]', '{}') THEN '' ELSE JSONExtractString(related_items, 1, 'sty_cd') END as first_sty,
    CASE WHEN related_items IN ('[]', '{}') THEN '' ELSE JSONExtractString(related_items, 2, 'sty_cd') END as second_sty,
    CASE WHEN related_items IN ('[]', '{}') THEN '' ELSE JSONExtractString(related_items, 3, 'sty_cd') END as third_sty,
    CASE WHEN related_items IN ('[]', '{}') THEN '' ELSE JSONExtractString(related_items, 4, 'sty_cd') END as forth_sty,
    CASE WHEN related_items IN ('[]', '{}') THEN '' ELSE JSONExtractString(related_items, 5, 'sty_cd') END as fifth_sty
  FROM agabang_dw.retooldb_item_md_assort
  WHERE substr(sty_col_cd, 4, 1) = '{{ seasonSelect2.value.slice(1, 2) }}' 
  AND substr(sty_col_cd, 3, 1) = '{{ seasonSelect2.value.slice(0, 1) }}' 
),
all_sty_codes AS (
  SELECT first_sty as sty_cd FROM extracted_sty_codes WHERE first_sty != ''
  UNION ALL
  SELECT second_sty as sty_cd FROM extracted_sty_codes WHERE second_sty != ''
  UNION ALL
  SELECT third_sty as sty_cd FROM extracted_sty_codes WHERE third_sty != ''
  UNION ALL
  SELECT forth_sty as sty_cd FROM extracted_sty_codes WHERE forth_sty != ''
  UNION ALL
  SELECT fifth_sty as sty_cd FROM extracted_sty_codes WHERE fifth_sty != ''
)
SELECT * 
FROM agabang_dw.seasonal_order_distribution 
WHERE season_cd = '{{ seasonSelect2.value.slice(1, 2) }}' 
  AND year_cd = '{{ getPreviousChar(seasonSelect2.value.slice(0, 1)) }}' 
  AND (sty_cd IN (SELECT DISTINCT sty_cd FROM all_sty_codes) OR sty_cd = '-');