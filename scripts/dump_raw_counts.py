# RUN python DWH-Project/scripts/dump_raw_counts.py > DWH-Project/answers/raw_counts.txt

import duckdb
import sys

# initialize db and table names
db = 'main.db'
tables = ['bike_data', 'central_park_weather', 'daily_citi_bike_trip_counts_and_weather', 'fhv_bases', 'fhv_tripdata', 'fhvhv_tripdata', 'green_tripdata', 'yellow_tripdata']

# create connection to duckdb
conn = duckdb.connect(db)

print('Table Name' + (' ' * 40) + 'Number of rows')
print('-' * 68)

# iterate through tables in table list
for table_name in tables:
    # get number of rows in table using sql query
    no_of_rows = conn.sql(f'SELECT COUNT(*) FROM {table_name};').fetchone()[0]

    # display table name and number of rows
    print(f'{table_name:50s} {no_of_rows}')