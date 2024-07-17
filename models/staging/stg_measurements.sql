{{ config(materialized='view') }}

SELECT
  MD5(CONCAT(station.station_short_name, CAST(measurement.time AS STRING), variable.actualName)) as measurement_id,
  ingestion_time,
  station.station_short_name,
  variable.reportName as parameter_report_name,
  variable.actualName as parameter_actual_name,
  variable.group as parameter_group,
  CAST(measurement.time AS TIMESTAMP) as measurement_time,
  CAST(measurement.value AS FLOAT64) as value,
  measurement.unit,
  measurement.QA as quality_flag,
  CAST(variable.elevation AS FLOAT64) as elevation,
  CAST(variable.interval AS INT64) as measurement_interval
FROM {{ source('raw', 'api_raw_data') }},
     UNNEST(stations) as station,
     UNNEST(station.variable) as variable,
     UNNEST(variable.measurements) as measurement