select date,
       snow,
       precipitation,
       min(snow) over seven_days as min_snow_7_day, -- include aggregates for snow over window in result 
       max(snow) over seven_days as max_snow_7_day,
       avg(snow) over seven_days as avg_snow_7_day,
       sum(snow) over seven_days as sum_snow_7_day,
       min(precipitation) over seven_days as min_prcp_7_day, -- include aggregates for precipitation over window in result
       max(precipitation) over seven_days as max_prcp_7_day,
       avg(precipitation) over seven_days as avg_prcp_7_day,
       sum(precipitation) over seven_days as sum_prcp_7_day       
from {{ ref('stg_central_park_weather') }}
window seven_days as (
order by date ASC
range between interval 3 days preceding 
          and interval 3 days following
) -- create 7-day moving window