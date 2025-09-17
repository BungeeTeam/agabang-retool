select 
  CASE WHEN status = '접수 대기' THEN 1
  WHEN status = '담당자 지정' THEN 2
  WHEN status = '처리 진행 중' THEN 3
  WHEN status = '해결 완료' THEN 4
  WHEN status = '처리 완료' THEN 5
  WHEN status = '보류' THEN 7
  WHEN status = '반영 예정' THEN 6
  ELSE 99 END as status_order,
  *
  from user_reports
order by 1 asc, submitted_at desc