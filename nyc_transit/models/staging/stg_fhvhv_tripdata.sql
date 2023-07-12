-- model for staging transformed fhvhv_tripdata

-- get reference to source data
with source as (
    select *
    from {{ source('main', 'fhvhv_tripdata')}}
),

-- cast data to appropriate type
-- give columns more meaningful name
renamed as (
    select
      hvfhs_license_num,
      dispatching_base_num,
      originating_base_num,
      request_datetime,
      on_scene_datetime,
      pickup_datetime,
      dropOff_datetime,
      PUlocationID as pickup_location_id,
      DOlocationID as dropoff_location_id,
      trip_miles,
      trip_time,
      base_passenger_fare,
      tolls,
      bcf as black_car_fund,
      sales_tax,
      congestion_surcharge,
      airport_fee,
      tips,
      driver_pay,

      -- use convert_yn_to_bool macro to convert columns to bool and rename
      {% set bool_cols = ['shared_request_flag', 'shared_match_flag', 'access_a_ride_flag', 'wav_request_flag', 'wav_match_flag'] %}
      {% set new_names = ['shared_request', 'shared_match', 'access_a_ride', 'wheelchair_accessible_vec_request', 'wheelchair_accessible_vec_match'] %}
      {% for i in range(bool_cols|length) %}
        {{ convert_yn_to_bool(bool_cols[i]) }} AS {{ new_names[i] }},
      {% endfor %}
      
      filename
    from source
)

select *
  from renamed