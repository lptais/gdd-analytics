/*
    This model joins the events, user and venues information.
*/
{{ config(materialized='table') }}


SELECT
  DISTINCT 
  a.user_id, 
  a.name as event_name, 
  a.response as user_response,
  a.status as event_status,
  a.created_date as event_created_date,
  a.user_when_date,
  a.venue_id,
  c.name as venue_name,
  c.country as venue_country,
  c.city as venue_city,
  b.country as user_country,
  b.city as user_city,
  a.rsvp_limit,
  a.days_to_rsvp, 
  IF(b.country=c.country, "True", "False") as same_country, 
  b.user_groups, 
  b.count_groups, 
  a.group_id, 
  d.name as group_name,
  d.city as group_city,
  d.created as group_created_date,
  d.topics as group_topics


from {{ ref('events') }} as a 
LEFT JOIN
  {{ ref('users') }} as b
USING
  (user_id)
LEFT JOIN
  {{ref ('venues')}} as c
USING
  (venue_id)
LEFT JOIN
{{ref ('groups')}} as d
USING 
(group_id)
