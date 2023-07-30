select trips.* -- select all columns from trips
  from {{ ref('mart__fact_all_taxi_trips') }} trips
  left join {{ ref('mart__dim_locations') }} locs
    on trips.pulocationid = locs.locationid -- join using pickup location
 where locs.locationid is null