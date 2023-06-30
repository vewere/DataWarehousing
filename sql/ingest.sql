-- RUN ./duckdb main.db -s ".read DWH-Project/sql/ingest.sql"

-- drop all tables if they exist
-- DROP TABLE bike_data;
-- DROP TABLE central_park_weather;
-- DROP TABLE daily_citi_bike_trip_counts_and_weather;
-- DROP TABLE fhv_bases;
-- DROP TABLE fhv_tripdata;
-- DROP TABLE fhvhv_tripdata;
-- DROP TABLE green_tripdata;
-- DROP TABLE yellow_tripdata;

-- create bike_data table from csv files using glob pattern
CREATE TABLE bike_data AS SELECT * FROM read_csv_auto('DWH-Project/data/bike/*.csv.gz', filename=true, union_by_name=true, all_varchar=1);

-- create central_park_weather from csv file
CREATE TABLE central_park_weather AS SELECT * FROM read_csv_auto('DWH-Project/data/central_park_weather.csv', filename=true);

-- create daily_citi_bike_trip_counts_and_weather from csv file
CREATE TABLE daily_citi_bike_trip_counts_and_weather AS SELECT * FROM read_csv_auto('DWH-Project/data/daily_citi_bike_trip_counts_and_weather.csv', filename=true);

-- create fhv_bases from csv file
CREATE TABLE fhv_bases AS SELECT * FROM read_csv_auto('DWH-Project/data/fhv_bases.csv', filename=true);

-- create fhv_tripdata from parquet files using glob pattern
CREATE TABLE fhv_tripdata AS SELECT * FROM read_parquet('DWH-Project/data/taxi/fhv_tripdata*.parquet', filename=true);

-- create fhvhv_tripdata from parquet files using glob pattern
CREATE TABLE fhvhv_tripdata AS SELECT * FROM read_parquet('DWH-Project/data/taxi/fhvhv_tripdata*.parquet', filename=true);

-- create green_tripdata from parquet files using glob pattern
CREATE TABLE green_tripdata AS SELECT * FROM read_parquet('DWH-Project/data/taxi/green_tripdata*.parquet', filename=true);

-- create yellow_tripdata from parquet files using glob pattern
CREATE TABLE yellow_tripdata AS SELECT * FROM read_parquet('DWH-Project/data/taxi/yellow_tripdata*.parquet', filename=true);