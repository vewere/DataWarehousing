-- model for staging transformed central_park_weather

-- get reference to source data
with source as (
    select *
    from {{ source('main', 'central_park_weather')}}
),

-- cast data to appropriate type
-- give columns more meaningful name
renamed as (
    select
      station,
      name,
      try_cast(date as date) as date,
      try_cast(awnd as double) as avg_wind_speed,
      try_cast(prcp as double) as precipitation,
      try_cast(snow as double) as snow,
      try_cast(snwd as double) as snow_depth,
      try_cast(tmax as int) as max_temperature,
      try_cast(tmin as int) as min_temperature,
      filename
    from source
)

select distinct(*) 
  from renamed