-- for each weekday, get the number of trips and total trip duration (in minutes)
-- trip start date is used to determine the weekday of the trip
select dayname(started_at_ts) as weekday, 
       count(*) as no_of_bike_trips,
       sum(duration_min) as total_duration_mins
  from {{ ref('mart__fact_all_bike_trips') }}
 where started_at_ts not null -- ensure that start/end dates are not null
   and ended_at_ts not null
 group by all