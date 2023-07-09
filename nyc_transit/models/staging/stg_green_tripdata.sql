-- model for staging transformed green_tripdata

-- get reference to source data
with source as (
    select *
    from {{ source('main', 'green_tripdata')}}
),

-- cast data to appropriate type
-- give columns more meaningful name
renamed as (
    select
      VendorID,
      lpep_pickup_datetime,
      lpep_dropoff_datetime,
      -- use convert_yn_to_bool macro to convert column to bool and rename
      {% set bool_col = 'store_and_fwd_flag' %}
      {% set new_name = 'store_and_forward_flag' %}
      {{ convert_yn_to_bool(bool_col) }} AS {{ new_name }},
      RatecodeID,
      PUlocationID as pickup_location_id,
      DOlocationID as dropoff_location_id,
      passenger_count,
      trip_distance,
      fare_amount,
      extra,
      mta_tax,
      tip_amount,
      tolls_amount,
      improvement_surcharge,
      total_amount,
      payment_type,
      trip_type,
      congestion_surcharge,
      filename
    from source
)

-- drop rows with no pickup/dropoff date, 0 trip_distance and 0 passenger_count
select distinct(*) 
  from renamed
 where lpep_pickup_datetime is not null
   and lpep_dropoff_datetime is not null
   and passenger_count > 0
   and trip_distance > 0