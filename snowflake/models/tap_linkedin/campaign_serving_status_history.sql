{{
   config(
     materialized='table'
   )
}}

SELECT ID as CAMPAIGN_ID,
       LAST_MODIFIED_TIME as CAMPAIGN_LAST_MODIFIED_TIME,
       STATUS

FROM {{ source('tap_linkedin', 'campaign') }} as campaign_serving_status_history