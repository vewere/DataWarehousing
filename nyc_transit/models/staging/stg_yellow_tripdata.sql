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

select * 
  from renamed