SELECT 
  CASE WHEN status = '접수 대기' THEN 1
       WHEN status = '담당자 지정' THEN 2
       WHEN status = '처리 진행 중' THEN 3
       WHEN status = '해결 완료' THEN 4
       WHEN status = '처리 완료' THEN 5
       WHEN status = '반영 예정' THEN 6
       WHEN status = '보류' THEN 7
       ELSE 99 
  END as status_order,
  id,
  submitted_at,
  last_updated_at,
  submitter_name,
  submitter_email,
  submitter_department,
  app_link,
  affected_app_version,
  category,
  user_priority,
  report_title,
  report_description,
  submitter_os_info,
  submitter_browser_info,
  assignee,
  assigned_at,
  status,
  resolution_summary,
  solution_details,
  resolved_at,
  resolved_version,
  admin_notes,
  related_ticket_id,
  admin_priority,
  admin_category,
  in_scope,
  app_name,
  slack_message_ts,
  slack_channel_id,
  slack_thread_ts
FROM user_reports
ORDER BY 1 ASC, submitted_at DESC