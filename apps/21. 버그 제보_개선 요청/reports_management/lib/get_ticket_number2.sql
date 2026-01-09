select
  end_dt - submitted_dt as lag_days,
  CAST(count(distinct id) as INT) as ticket_cnt
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
group by lag_days