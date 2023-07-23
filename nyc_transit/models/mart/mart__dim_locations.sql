-- read the data in the seed file for taxi zone lookup into the mart
select {{ dbt_utils.star(ref('taxi+_zone_lookup')) }}
  from {{ ref('taxi+_zone_lookup') }}