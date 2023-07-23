-- join all taxi trips with dim locations, drop records where the service zone of the dropoff location is not airports or EWR
-- and count the number of records retrieved
select sum(case
             when LOWER(service_zone) = 'airports' then 1 else 0
           end) as "Trips ending in Airport zone", -- count cases where the trip ended in an airport zone only
       sum(case
             when LOWER(service_zone) = 'ewr' then 1 else 0
           end) as "Trips ending in EWR zone", -- count cases where the trip ended in an ewr zone only
       count(*) as total -- count both cases
  from {{ ref('mart__fact_all_taxi_trips') }} 
  join {{ ref('mart__dim_locations') }} on (DOlocationID = LocationID)
 where (LOWER(service_zone) = 'airports' -- use lower to prevent case mismatch in service zone names
    or LOWER(service_zone) = 'ewr')
   and pickup_datetime not null -- ensure that pickup/dropoff dates are not null
   and dropOff_datetime not null