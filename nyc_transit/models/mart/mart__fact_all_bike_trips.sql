-- extract facts from bike table
-- calculate trip duration in mins and secs
select start_time as started_at_ts,
       stop_time as ended_at_ts,
       start_station_id,
       end_station_id,
       datediff('minute', start_time, stop_time) as duration_min,
       datediff('second', start_time, stop_time) as duration_sec,
  from {{ ref('stg_bike_data') }}