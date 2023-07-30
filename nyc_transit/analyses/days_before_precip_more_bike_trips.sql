-- get a list of days before the day it rained/snowed
with preceding_days as (
    select lag(started_at_ts) over (order by started_at_ts) as day
from {{ ref('mart__fact_all_bike_trips') }} trips
join {{ ref('stg_central_park_weather') }} weather
on try_cast(trips.started_at_ts as date) = weather.date -- join on trip start date
where precipitation > 0 or snow > 0
),

-- get a list of days it rained/snowed
prcp_snow_days as (
    select started_at_ts as day
from {{ ref('mart__fact_all_bike_trips') }} trips
join {{ ref('stg_central_park_weather') }} weather
on try_cast(trips.started_at_ts as date) = weather.date -- join on trip start date
where precipitation > 0 or snow > 0
),

-- count no of trips by day
trips_on_preceding_days as (
    select day,
           count(*) as no_of_trips
    from preceding_days
    group by day
),

trips_on_prcp_snow_days as (
    select day,
           count(*) as no_of_trips
    from prcp_snow_days
    group by day
),

-- get average no of trips
avg_trips_on_preceding_days as (
    select avg(no_of_trips) as avg_trips_on_preceding
    from trips_on_preceding_days
),

avg_trips_on_prcp_snow_days as (
    select avg(no_of_trips) as avg_trips_on_prcp_snow
    from trips_on_prcp_snow_days
)

-- display results
select 
    (select avg_trips_on_prcp_snow from avg_trips_on_prcp_snow_days) as average_trips_on_prcp_snow_days,
    (select avg_trips_on_preceding from avg_trips_on_preceding_days) as average_trips_on_preceding_days;