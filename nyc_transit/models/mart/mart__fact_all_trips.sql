-- combine bike, fhv, fhvhv, yellow and green taxi data into one table
-- use union all to capture similar records across the different types of trips
with all_trips as (
    select 'bike' as type,
           start_time as started_at_ts,
           stop_time as ended_at_ts
      from {{ ref('stg_bike_data') }}
    union all
    select 'fhv',
           pickup_datetime,
           dropOff_datetime
      from {{ ref('stg_fhv_tripdata') }}
    union all
    select 'fhvhv',
           pickup_datetime,
           dropOff_datetime
      from {{ ref('stg_fhvhv_tripdata') }}
    union all
    select 'yellow',
           tpep_pickup_datetime,
           tpep_dropoff_datetime
      from {{ ref('stg_yellow_tripdata') }}
    union all
    select 'green',
           lpep_pickup_datetime,
           lpep_dropoff_datetime
      from {{ ref('stg_green_tripdata') }}
)

-- calculate duration_min and duration_sec from the result above
-- and add it to the returned result
select type,
       started_at_ts,
       ended_at_ts,
       datediff('minute', started_at_ts, ended_at_ts) as duration_min,
       datediff('second', started_at_ts, ended_at_ts) as duration_sec
  from all_trips