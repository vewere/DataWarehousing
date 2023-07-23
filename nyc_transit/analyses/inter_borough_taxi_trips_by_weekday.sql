-- for each weekday, get the number of interborough trips and % of interborough trips
-- trip pickup date is used to determine the weekday of the trip
select dayname(pickup_datetime) as weekday,
       sum(case 
             when start_loc.borough != end_loc.borough then 1 else 0
           end) interborough_trips_count, -- count the cases where start and end boroughs are different
       (sum(case 
             when start_loc.borough != end_loc.borough then 1 else 0
           end) / count(pickup_datetime) * 100) as "% of Interborough trips", -- calculate % of interborough trips
  from {{ ref('mart__fact_all_taxi_trips') }} 
  left join {{ ref('mart__dim_locations') }} start_loc on (pulocationid = locationid) -- left join ensures that no trip record is lost while joining
  left join {{ ref('mart__dim_locations') }} end_loc on (dolocationid = end_loc.locationid)
 where pickup_datetime not null -- ensure that pickup/dropoff dates are not null
   and dropOff_datetime not null
 group by all


-- -- another method I tried that eventually gave similar results
-- select interborough_trips.weekday as weekday, 
--        interborough_trips_count,
--        (interborough_trips_count / total_trips_count) * 100 as "% of Interborough trips"
--   from (select dayname(pickup_datetime) as weekday,
--                count(pickup_datetime) as interborough_trips_count
--           from {{ ref('mart__fact_all_taxi_trips') }} 
--           join {{ ref('mart__dim_locations') }} start_loc on (pulocationid = locationid) 
--           join {{ ref('mart__dim_locations') }} end_loc on (dolocationid = end_loc.locationid)
--          where start_loc.borough != end_loc.borough
--            and pickup_datetime not null
--            and dropOff_datetime not null
--          group by all) interborough_trips 
--          join (select dayname(pickup_datetime) as weekday,
--                       count(pickup_datetime) as total_trips_count
--                  from {{ ref('mart__fact_all_taxi_trips') }}
--                 where pickup_datetime not null
--                   and dropOff_datetime not null
--                 group by all) total_trips 
--            on (interborough_trips.weekday = total_trips.weekday)


