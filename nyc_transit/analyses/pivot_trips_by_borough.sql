pivot {{ ref('mart__fact_trips_by_borough') }}
   on borough
using first(no_of_trips); -- using first because the table already has the counts aggregated

-- I tried the dbt_utils function, but couldn't get the syntax right
-- select {{ dbt_utils.pivot('borough', dbt_utils.get_column_values(ref('mart__fact_trips_by_borough'), 'borough')) }}
--   from {{ ref('mart__fact_trips_by_borough') }}