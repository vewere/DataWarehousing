select zone,
       count(*) as no_of_trips
  from {{ ref('mart__fact_all_taxi_trips') }} trips
  left join {{ ref('mart__dim_locations') }} locs
    on trips.pulocationid = locs.locationid -- join using pickup location
 group by zone
having count(*) < 100000
order by count(*) desc