{{
   config(
     materialized='table'
   )
}}

SELECT *
FROM {{ source('tap_linkedin', 'ad_analytics_by_campaign') }} as ad_analytics_by_campaign