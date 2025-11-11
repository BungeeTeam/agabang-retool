-- year_cd가 null인 경우만 업데이트
UPDATE item_md_info
SET year_cd = SUBSTRING(sty_cd FROM 3 FOR 1)
WHERE year_cd IS NULL AND sty_cd IS NOT NULL;

-- sesn_cd가 null인 경우만 업데이트
UPDATE item_md_info
SET sesn_cd = SUBSTRING(sty_cd FROM 4 FOR 1)
WHERE sesn_cd IS NULL AND sty_cd IS NOT NULL;

-- it_gb_cd가 null인 경우만 업데이트
UPDATE item_md_info
SET it_gb_cd = SUBSTRING(sty_cd FROM 5 FOR 2)
WHERE it_gb_cd IS NULL AND sty_cd IS NOT NULL;