-- model for staging transformed yellow_tripdata

-- get reference to source data
with source as (
    select *
    from {{ source('main', 'yellow_tripdata')}}
),

-- cast data to appropriate type
-- give columns more meaningful name
renamed as (
    select
      VendorID,
      tpep_pickup_datetime,
      tpep_dropoff_datetime,
      passenger_count,
      trip_distance,
      RatecodeID,
      -- use convert_yn_to_bool macro to convert column to bool and rename
      {% set bool_col = 'store_and_fwd_flag' %}
      {% set new_name = 'store_and_forward_flag' %}
      {{ convert_yn_to_bool(bool_col) }} AS {{ new_name }}, 
      PUlocationID as pickup_location_id,
      DOlocationID as dropoff_location_id,
      payment_type,
      fare_amount,
      extra,
      mta_tax,
      tip_amount,
      tolls_amount,
      improvement_surcharge,
      total_amount,
      congestion_surcharge,
      airport_fee,      
      filename
    from source
)

-- drop rows with no pickup/dropoff date, 0 trip_distance and 0 passenger_count
select distinct(*) 
  from renamed
 where tpep_pickup_datetime is not null
   and tpep_dropoff_datetime is not null
   and trip_distance > 0
   and passenger_count > 0