/*
    This model returns the groups table.
*/
{{ config(materialized='table') }}

SELECT
  group_id,
  name,
  city,
  DATE(TIMESTAMP_MILLIS(created)) AS created,
  STRING_AGG(topics, " & ") AS topics
FROM
  `gdd-analytics-engineer.landing_zone_airbyte.groups`,
  UNNEST(topics) AS topics
GROUP BY
  1,
  2,
  3,
  4