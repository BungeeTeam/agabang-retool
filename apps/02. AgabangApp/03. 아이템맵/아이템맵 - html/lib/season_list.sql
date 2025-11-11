SELECT
    c1.*,
    CASE WHEN c1.sesn_cd in ('2','4','6','8') THEN concat(c1.year_sesn_nm_eng,'(시즌코드:',c1.sesn_cd,')')
        ELSE c1.year_sesn_nm_eng END as year_season_label,
    c2.year_cd as prev_year_cd,
    concat(c2.year_cd, c2.sesn_cd) as prev_year_season_cd
FROM agabang_dw.code_season c1
LEFT JOIN agabang_dw.code_season c2
    ON c1.sesn_cd = c2.sesn_cd
    AND toInt32(c1.year_nm) = toInt32(c2.year_nm) + 1
WHERE 1=1
    AND c1.year_nm <= '{{ moment().add(1, 'year').year() }}'
    AND c1.sesn_cd != '0'
ORDER BY c1.year_nm DESC, c1.sesn_cd DESC;