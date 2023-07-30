select date,
       precipitation,
       avg(precipitation) over (
order by date ASC
range between interval 3 days preceding and
interval 3 days following) as seven_day_moving_avg -- create 7 day moving window
from {{ ref('stg_central_park_weather') }}