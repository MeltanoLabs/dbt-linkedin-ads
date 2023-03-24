{{
   config(
     materialized='table'
   )
}}

SELECT *
FROM {{ source('tap_linkedin', 'ad_analytics_by_creative') }} as ad_analytics_by_creative