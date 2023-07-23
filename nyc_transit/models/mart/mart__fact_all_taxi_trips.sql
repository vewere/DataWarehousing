-- combine fhv, fhvhv, yellow and green taxi data into one table
-- use union all to capture similar records across the different types of trips
with all_taxi_trips as (
    select 'fhv' as type,
           pickup_datetime,
           dropOff_datetime,
           pickup_location_id as PUlocationID,
           dropoff_location_id as DOlocationID
      from {{ ref('stg_fhv_tripdata') }}
    union all
    select 'fhvhv' as type,
           pickup_datetime,
           dropOff_datetime,
           pickup_location_id,
           dropoff_location_id
      from {{ ref('stg_fhvhv_tripdata') }}
    union all
    select 'yellow' as type,
           tpep_pickup_datetime,
           tpep_dropoff_datetime,
           pickup_location_id,
           dropoff_location_id
      from {{ ref('stg_yellow_tripdata') }}
    union all
    select 'green' as type,
           lpep_pickup_datetime,
           lpep_dropoff_datetime,
           pickup_location_id,
           dropoff_location_id
      from {{ ref('stg_green_tripdata') }}
)

-- calculate duration_min and duration_sec from the result above
-- and add it to the returned result
select type,
       pickup_datetime,
       dropOff_datetime,
       datediff('minute', pickup_datetime, dropOff_datetime) as duration_min,
       datediff('second', pickup_datetime, dropOff_datetime) as duration_sec,
       PUlocationID,
       DOlocationID
  from all_taxi_trips