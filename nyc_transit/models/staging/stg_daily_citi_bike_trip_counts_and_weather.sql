-- model for staging transformed daily_citi_bike_trip_counts_and_weather

-- get reference to source data
with source as (
    select *
    from {{ source('main', 'daily_citi_bike_trip_counts_and_weather')}}
),

-- cast data to appropriate type
-- give columns more meaningful name
renamed as (
    select
      try_cast(date as date) as date,
      try_cast(trips as int) as no_of_trips,
      try_cast(precipitation as double) as precipitation,
      try_cast(snow_depth as double) as snow_depth,
      try_cast(snowfall as double) as snowfall,
      try_cast(max_temperature as double) as max_temperature,
      try_cast(min_temperature as double) as min_temperature,
      try_cast(average_wind_speed as double) as average_wind_speed,
      try_cast(dow as int) as day_of_week,
      try_cast(year as int) as year,
      try_cast(month as int) as month,
      try_cast(holiday as boolean) as is_holiday,
      try_cast(stations_in_service as int) as stations_in_service,
      try_cast(weekday as boolean) as is_weekday,
      try_cast(weekday_non_holiday as boolean) as is_weekday_non_holiday,
      filename
    from source
)

select distinct(*) 
  from renamed