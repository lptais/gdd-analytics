/*
    This model joins the events, user and venues information.
*/
{{ config(materialized='table') }}


SELECT
  DISTINCT 
  a.user_id, 
  b.city as user_city,
  UPPER(b.country) as user_country,
  a.name as event_name, 
  a.response as user_response,
  a.status as event_status,
  a.created_date as event_created_date,
  a.group_id, 
  a.rsvp_limit,
  a.days_to_rsvp, 
  a.venue_id,
  c.name as venue_name,
  c.city as venue_city,
  UPPER(c.country) as venue_country,
  IF(UPPER(b.country)=UPPER(c.country), "True", "False") as same_country, 
  b.user_groups, 
  b.count_groups

from {{ ref('events') }} as a 
LEFT JOIN
  {{ ref('users') }} as b
USING
  (user_id)
LEFT JOIN
  {{ref ('venues')}} as c
USING
  (venue_id)