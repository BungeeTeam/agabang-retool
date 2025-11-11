-- additionalScope 로 전달된 변수 사용
INSERT INTO discontinued_products (
    sty_cd,
    col_cd,
    is_discontinued,
    discontinued_date,
    discontinued_by
)
SELECT
    item_data.sty_cd,
    item_data.col_cd,
    true,
    CURRENT_TIMESTAMP,
    {{ current_user.email }}
FROM
    jsonb_to_recordset({{ discontinuedItemsList }}::jsonb) AS item_data (sty_cd TEXT, col_cd TEXT)
WHERE
    item_data.sty_cd IS NOT NULL AND item_data.col_cd IS NOT NULL
ON CONFLICT (sty_cd, col_cd)
DO UPDATE SET
    is_discontinued = true,
    discontinued_date = CURRENT_TIMESTAMP,
    discontinued_by = {{ current_user.email }};