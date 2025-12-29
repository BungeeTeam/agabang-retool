SELECT 
file_attachments
FROM user_reports
where id = {{ varSelectedRow.value.id }}
