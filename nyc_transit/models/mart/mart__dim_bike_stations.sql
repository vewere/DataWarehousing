-- the first part gets the details of all unique start stations
-- the second part gets the details of all unique end stations
select distinct start_station_id as station_id,
                start_station_name as station_name,
                start_latitude as station_lat,
                start_longitude as station_lng
  from {{ ref('stg_bike_data') }}
union -- using union combine both results and drop duplicate rows
select distinct end_station_id,
                end_station_name,
                end_latitude,
                end_longitude
  from {{ ref('stg_bike_data') }}