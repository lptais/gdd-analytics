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
  a.created as event_created_date,
  a.group_id, 
  a.rsvp_limit,
  a.days_to_rsvp, 
  a.venue_id,
  c.name as venue_name,
  c.city as venue_city,
  UPPER(c.country) as venue_country,
  IF(UPPER(b.country)=UPPER(c.country), "True", "False") as same_country

from {{ ref('events_user_level') }} as a 
LEFT JOIN
  (SELECT user_id, city, country, STRING_AGG(group_id) from {{ ref('users') }} group by 1,2,3) as b
USING
  (user_id)
LEFT JOIN
  {{ref ('venues')}} as c
USING
  (venue_id)