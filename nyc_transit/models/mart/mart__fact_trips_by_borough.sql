select COALESCE(borough, 'No Match') as borough, -- capture trips that don't have a matching borough as No Match
       count(*) as no_of_trips
  from {{ ref('mart__fact_all_taxi_trips') }} trips
  left join {{ ref('mart__dim_locations') }} locs -- left join to ensure all trips are in the mart
    on trips.pulocationid = locs.locationid -- using pickup location to join
 group by borough