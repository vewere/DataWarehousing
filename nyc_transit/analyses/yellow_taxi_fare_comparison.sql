select fare_amount,
       zone,
       borough,
       avg(fare_amount) over (partition by zone) as avg_fare_by_zone, -- get average fare by zone
       avg(fare_amount) over (partition by borough) as avg_fare_by_borough, -- get average fare by borough
       avg(fare_amount) over () as avg_fare -- get overall average fare
       from {{ ref('stg_yellow_tripdata') }} yellow_trips
       join {{ ref('mart__dim_locations') }} locs
         on yellow_trips.pickup_location_id = locs.locationid -- join using pickup location
 where borough in ('Queens', 'Brooklyn') -- adding these conditions to limit the output because the process always resulted in an out of memory error
   or zone in ('Upper East Side South', 'Upper East Side North', 'Midtown Center')