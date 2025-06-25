-- models/marts/fact/fact_bike_thefts.sql

with s as (
  select * from {{ ref('stg_bike_thefts') }}
),
d_start as (
  select datetime, datetime_id from {{ ref('dim_datetime') }}
),
d_end as (
  select datetime, datetime_id from {{ ref('dim_datetime') }}
),
created_dates as (
  select date, date_id from {{ ref('dim_dates') }}
),
start_dates as (
  select date, date_id from {{ ref('dim_dates') }}
),
end_dates as (
  select date, date_id from {{ ref('dim_dates') }}
)

select
  row_number() over (order by s.angelegt_am, s.tatzeit_anfang_stunde) as theft_id,
  ds.datetime_id as start_datetime_id,
  de.datetime_id as end_datetime_id,
  cd.date_id as created_date_id,
  sd.date_id as incident_start_date_id,
  ed.date_id as incident_end_date_id,
  loc.location_id,
  bt.bike_type_id,
  off.offense_id,
  rr.record_reason_id,
  s.damage_amount,
  s.is_attempted
from s
left join d_start ds
  on DATEADD('hour', s.tatzeit_anfang_stunde, s.tatzeit_anfang_datum) = ds.datetime
left join d_end de
  on DATEADD('hour', s.tatzeit_ende_stunde, s.tatzeit_ende_datum) = de.datetime
left join created_dates cd 
  on s.angelegt_am = cd.date
left join start_dates sd 
  on s.tatzeit_anfang_datum = sd.date
left join end_dates ed 
  on s.tatzeit_ende_datum = ed.date
left join {{ ref('dim_locations') }} loc 
  on s.lor = loc.lor_code
left join {{ ref('dim_bike_types') }} bt 
  on s.bike_type = bt.bike_type
left join {{ ref('dim_offenses') }} off 
  on s.offense = off.offense
left join {{ ref('dim_record_reasons') }} rr 
  on s.record_reason = rr.record_reason
