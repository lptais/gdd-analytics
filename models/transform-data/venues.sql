/*
    This model selecs the relevant columns from the venues table.
*/

{{ config(materialized='table') }}

SELECT
  venue_id,
  name,
  UPPER(country) as country,
  city
FROM
  `gdd-analytics-engineer.landing_zone_airbyte.venues`