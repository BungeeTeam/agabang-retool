SELECT
*,
CASE WHEN CAST(sesn_cd as integer) % 2 = 0 
        THEN CONCAT(year_sesn_nm_eng,' (마트)')
    ELSE year_sesn_nm_eng END as year_season_name
FROM code_season
WHERE 
  CASE
    WHEN '{{select_season_type.value}}' = 'season'
      then sesn_cd != '0'
    ELSE sesn_cd = '0' END
 -- AND CASE WHEN sesn_cd = '0' THEN CAST(year_nm as integer) >= 2023 ELSE true END
    AND CAST(year_nm as integer) >= 2023
ORDER BY year_nm desc, sesn_cd desc