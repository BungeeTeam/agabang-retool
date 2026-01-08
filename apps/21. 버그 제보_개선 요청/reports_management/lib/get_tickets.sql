select
*,
 end_dt - submitted_dt as lag_days,
  resolved_at - submitted_at as real_lag,
  to_char(submitted_dt, 'YYYY-MM') AS year_month,
  to_char(submitted_dt, 'IYYY-IW') AS year_week_num, 
  submitted_dt as dt
from (
  select 
  *, 
  CAST(submitted_at AS date) as submitted_dt,
  CAST(COALESCE(resolved_at, CURRENT_DATE) AS date) as end_dt  
  from user_reports
  ) as t1
where submitted_dt between '{{dateRange1.value.start}}'
 and '{{ dateRange1.value.end }}' 
 and t1.submitter_name != '클리브'