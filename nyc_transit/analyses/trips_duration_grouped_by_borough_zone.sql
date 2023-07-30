select borough,
       zone,
       count(*) as no_of_trips,
       avg(duration_min) as avg_duration_mins -- get average trip duration in minutes
  from {{ ref('mart__fact_all_taxi_trips') }} trips
  left join {{ ref('mart__dim_locations') }} locs 
    on trips.pulocationid = locs.locationid -- join using the pickup location
 group by borough, zone
 order by borough, zone