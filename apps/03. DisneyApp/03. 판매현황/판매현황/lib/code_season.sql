SELECT
*
FROM code_season
WHERE 
  CASE
    WHEN '{{select_item_type.value}}' = 'season'
      then sesn_cd in ('1','3','5','7')
    WHEN '{{select_item_type.value}}' = 'mart'
        then sesn_cd in ('2','4','6','8')
    ELSE sesn_cd = '0'END
ORDER BY year_nm desc, sesn_cd desc