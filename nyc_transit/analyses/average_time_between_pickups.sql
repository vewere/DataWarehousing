with time_between_pickups as (
    select zone,
           -- get difference between current pickup time and next pickup time in minutes
           datediff('minute', pickup_datetime, lead(pickup_datetime) over (partition by zone order by pickup_datetime)) time_between
    from {{ ref('mart__fact_all_taxi_trips') }} trips
join {{ ref('mart__dim_locations') }} locs
on trips.pulocationid = locs.locationid -- join using pickup location
where zone in ('Upper East Side South', 'Upper East Side North', 'Midtown Center') -- limiting results to prevent out of memory error
)

select zone,
       avg(time_between) as avg_time_between_pickups -- get average time between pickups by zone
from time_between_pickups
group by zone
