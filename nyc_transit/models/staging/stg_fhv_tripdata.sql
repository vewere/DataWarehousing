-- model for staging transformed fhv_tripdata

-- get reference to source data
with source as (
    select *
    from {{ source('main', 'fhv_tripdata')}}
),

-- give columns more meaningful name
renamed as (
    select
      -- remove trailing whitespace and convert to uppercase to resolve with matching to a value in the fhv_bases table
      UPPER(RTRIM(dispatching_base_num)) as dispatching_base_num,
      pickup_datetime,
      dropOff_datetime,
      PUlocationID as pickup_location_id,
      DOlocationID as dropoff_location_id,
      -- drop sr_flag column since it is always null
      Affiliated_base_number,
      filename
    from source
)

select * 
  from renamed