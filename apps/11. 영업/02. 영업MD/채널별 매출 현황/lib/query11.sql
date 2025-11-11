select
*
from agabang_dw.dim_style
where CAST(season_cd as INT) in ({{ switchGroup1.value }})
limit 1;