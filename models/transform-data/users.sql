/*
    This model flattens the users table.
*/

{{ config(materialized='table') }}

SELECT
  user_id,
  country,
  city,
  memberships.group_id,
  DATE(TIMESTAMP_MILLIS(memberships.joined)) as joined_date
FROM
  `gdd-analytics-engineer.landing_zone.users`,
  UNNEST(memberships) AS memberships