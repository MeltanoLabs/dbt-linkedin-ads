{{
   config(
     materialized='table'
   )
}}

SELECT ID as CAMPAIGN_GROUP_ID,
       LAST_MODIFIED_TIME as CAMPAIGN_GROUP_LAST_MODIFIED_TIME,
       STATUS

FROM {{ source('tap_linkedin', 'campaign_groups') }} as campaign_group_serving_status_history
