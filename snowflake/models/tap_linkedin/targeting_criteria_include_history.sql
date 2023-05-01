{{
   config(
     materialized='view'
   )
}}

SELECT ID as CAMPAIGN_ID,
       LAST_MODIFIED_TIME as CAMPAIGN_LAST_MODIFIED_TIME,
       FACET_NAME,
       FACET_VALUE,
       0 AS INDEX,
       _SDC_BATCHED_AT

FROM {{ source('tap_linkedin', 'campaign') }} as campaign_serving_status_history