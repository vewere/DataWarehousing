-- model for staging transformed fhv_tripdata

-- get reference to source data
with source as (
    select *
    from {{ source('main', 'fhv_tripdata')}}
),

-- give columns more meaningful name
renamed as (
    select
      dispatching_base_num,
      pickup_datetime,
      dropOff_datetime,
      PUlocationID as pickup_location_id,
      DOlocationID as dropoff_location_id,
      Affiliated_base_number,
      filename
    from source
)

-- drop rows with no pickup/dropoff date
select distinct(*) 
  from renamed
 where pickup_datetime is not null
   and dropOff_datetime is not null