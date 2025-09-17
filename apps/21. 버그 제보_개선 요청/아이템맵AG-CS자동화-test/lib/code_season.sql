SELECT
*,
concat(year_nm,'(',year_cd,')') as year_label
FROM code_season
WHERE 
  CASE
    WHEN '{{select_season_type.value}}' = 'season'
      then sesn_cd in ('1','3','5','7')
    ELSE sesn_cd = '0'END
ORDER BY year_nm desc, sesn_cd desc