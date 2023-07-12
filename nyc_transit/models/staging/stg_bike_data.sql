-- model for staging transformed bike_data

-- get reference to source data
with source as (
    select *
    from {{ source('main', 'bike_data')}}
),

-- cast data to appropriate type
-- columns with the same information are merged using COALESCE
-- give columns more meaningful name
renamed as (
    select
      TRY_CAST(tripduration AS int) AS tripduration,
      TRY_CAST(COALESCE(starttime, started_at) AS datetime) AS start_time,
      TRY_CAST(COALESCE(stoptime, ended_at) AS datetime) AS stop_time,
      TRY_CAST(COALESCE("start station id", start_station_id) AS int) AS start_station_id,
      TRY_CAST(COALESCE("end station id", end_station_id) AS int) AS end_station_id,
      COALESCE("start station name", start_station_name) AS start_station_name,
      COALESCE("end station name", end_station_name) AS end_station_name,
      TRY_CAST(COALESCE("start station latitude", start_lat) AS double) AS start_latitude,
      TRY_CAST(COALESCE("start station longitude", start_lng) AS double) AS start_longitude,
      TRY_CAST(COALESCE("end station latitude", end_lat) AS double) AS end_latitude,
      TRY_CAST(COALESCE("end station longitude", end_lng) AS double) AS end_longitude,
      TRY_CAST(bikeid AS int) AS bikeid,
      usertype,
      TRY_CAST("birth year" AS int) AS birth_year,
      TRY_CAST(gender AS int) AS gender,
      ride_id,
      rideable_type,
      member_casual,
      filename
    from source
)

select *
  from renamed