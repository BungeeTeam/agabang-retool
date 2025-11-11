SELECT
*
FROM channel_group_mapping
WHERE biz_cd = '{{ bizSelect.value }}'
and biz_cd != 'ZZ'
ORDER BY tp_group_nm desc