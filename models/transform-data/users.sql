/*
    This model joins user information.
*/

{{ config(materialized='table') }}

SELECT
  user_id,
  UPPER(country) as country,
  city,
  STRING_AGG(DISTINCT group_id, " & ") as user_groups,
  COUNT(DISTINCT group_id) as count_groups
FROM
  `gdd-analytics-engineer.landing_zone_airbyte.users`
JOIN
  `gdd-analytics-engineer.landing_zone_airbyte.users_memberships`
USING
  (_airbyte_users_hashid)
GROUP BY
  1,
  2,
  3