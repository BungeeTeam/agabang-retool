select
  *
from agabang.cfempl_aga
where
  -- team_cd in ('D830010', 'D800040', 'D290210') 
  dept_cd in ('D830010','D800040')
order by emp_name