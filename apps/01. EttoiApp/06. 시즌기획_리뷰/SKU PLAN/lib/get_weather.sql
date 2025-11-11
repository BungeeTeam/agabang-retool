select
  date as "날짜",
  daily_temp_min as "최저기온",
  daily_temp_max as "최고기온",
  daily_temp_avg as "평균기온",
  daily_snow_amount as "적설량",
  daily_rain_amount as "강우량"
from weather_data
where region_code = '108'
AND date > CURRENT_DATE - INTERVAL '4 years'
order by date asc