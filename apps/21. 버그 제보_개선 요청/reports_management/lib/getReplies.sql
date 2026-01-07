select * from replies where user_reports_id = {{ varSelectedRow.value?.id }} 
order by submitted_time asc