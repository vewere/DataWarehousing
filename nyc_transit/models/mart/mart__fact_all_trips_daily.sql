-- for each day, count the total number of trips and find the average trip duration (in minutes)
-- trip start date is used to determine the day of the trip
select type,
       date_trunc('day', started_at_ts) as date,
       count(*) as trips,
       avg(duration_min) as average_trip_duration_min
  from {{ ref('mart__fact_all_trips') }}
  group by all