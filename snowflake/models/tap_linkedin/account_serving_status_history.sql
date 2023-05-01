{{
   config(
     materialized='view'
   )
}}


SELECT ID as ACCOUNT_ID,
       LAST_MODIFIED_TIME as ACCOUNT_LAST_MODIFIED_TIME,
       STATUS,
       _SDC_BATCHED_AT
     


FROM {{ source('tap_linkedin', 'account') }} as account_serving_status_history
