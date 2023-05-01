{{
   config(
     materialized='view'
   )
}}

SELECT ID as CREATIVE_ID,
       LAST_MODIFIED_TIME as CREATIVE_LAST_MODIFIED_TIME,
       STATUS,
       _SDC_BATCHED_AT

FROM {{ source('tap_linkedin', 'creatives') }} as creative_serving_status_history