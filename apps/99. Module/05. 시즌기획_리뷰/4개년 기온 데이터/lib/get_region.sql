select
  region_code,
  region_name
from agabang_dw.retooldb_weather_data
group by 1,2