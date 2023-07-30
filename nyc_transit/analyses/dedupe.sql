 select {{ dbt_utils.star(ref('events')) }} -- get events from seed file
   from {{ ref('events') }}
qualify row_number() over (partition by event_id order by insert_timestamp desc) = 1 -- get the lastest insertion for current event id
