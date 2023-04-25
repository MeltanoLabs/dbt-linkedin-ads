{{
   config(
     materialized='table'
   )
}}


SELECT ID as ACCOUNT_ID,
       LAST_MODIFIED_TIME as ACCOUNT_LAST_MODIFIED_TIME,
       STATUS
     


FROM {{ source('tap_linkedin', 'account') }} as account_serving_status_history
