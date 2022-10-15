
/*
    This model normalizes the events table.
    Through UNNEST(rsvps) it captures user-level information.
*/
{{ config(materialized='view') }}

SELECT
    rsvps.user_id,
    name,
    status,
    venue_id,
    group_id,
    TIMESTAMP_MILLIS(CAST(time AS INT64)) AS time,
    DATE(TIMESTAMP_MILLIS(created)) AS created,
    IFNULL(ROUND(duration/3600,1),0) AS duration_hours,
    rsvp_limit,
    rsvps.response,
    DATE(TIMESTAMP_MILLIS(rsvps.when)) AS user_when,
    DATE_DIFF(DATE(TIMESTAMP_MILLIS(rsvps.when)),DATE(TIMESTAMP_MILLIS(created)), DAY) AS days_to_rsvp,
    rsvps.guests
  FROM
    `gdd-analytics-engineer.landing_zone.events`,
    UNNEST(rsvps) AS rsvps
