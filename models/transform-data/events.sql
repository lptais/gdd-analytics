
/*
    This model joins the events tables.
*/
{{ config(materialized='table') }}

SELECT
  user_id,
  response, 
  name, 
  status,
  venue_id,
  group_id, 
  TIMESTAMP_MILLIS(CAST(time AS INT64)) AS time,
  DATE(TIMESTAMP_MILLIS(created)) AS created_date,
  IFNULL(ROUND(duration/3600,1),0) AS duration_hours,
  IFNULL(rsvp_limit, 0) as rsvp_limit,
  DATE(TIMESTAMP_MILLIS (a.when)) AS user_when_date,
  DATE_DIFF(DATE(TIMESTAMP_MILLIS(a.when)),DATE(TIMESTAMP_MILLIS(created)), DAY) AS days_to_rsvp,
  guests

FROM
  `gdd-analytics-engineer.landing_zone_airbyte.events_rsvps` as a
JOIN
  `gdd-analytics-engineer.landing_zone_airbyte.events` as b
USING
  (_airbyte_events_hashid)