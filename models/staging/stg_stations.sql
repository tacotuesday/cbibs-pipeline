{{ config(materialized='view') }}

SELECT DISTINCT
  station_short_name,
  station_long_name,
  active as is_active,
  latitude,
  longitude,
  ingestion_time as last_updated
FROM {{ source('raw', 'api_raw_data') }},
     UNNEST(stations) as station