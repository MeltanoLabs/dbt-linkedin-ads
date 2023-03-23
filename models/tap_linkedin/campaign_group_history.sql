{{
   config(
     materialized='table'
   )
}}

SELECT *
FROM {{ source('tap_linkedin', 'campaign_groups') }} as campaign_group_history