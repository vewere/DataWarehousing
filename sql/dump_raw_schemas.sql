-- RUN ./duckdb main.db -s ".read DWH-Project/sql/dump_raw_schemas.sql" > DWH-Project/answers/raw_schemas.txt

.echo on

-- show all tables
SHOW ALL TABLES;

-- show schema for all tables
DESCRIBE bike_data;
DESCRIBE central_park_weather;
DESCRIBE daily_citi_bike_trip_counts_and_weather;
DESCRIBE fhv_bases;
DESCRIBE fhv_tripdata;
DESCRIBE fhvhv_tripdata;
DESCRIBE green_tripdata;
DESCRIBE yellow_tripdata;