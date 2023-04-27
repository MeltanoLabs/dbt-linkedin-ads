{{
   config(
     materialized='table'
   )
}}

SELECT ACCOUNT_ID,
       USER_PERSON_ID as ID,
       LAST_MODIFIED_TIME,
       ROLE,
       CREATED_TIME,
       _SDC_BATCHED_AT

FROM {{ source('tap_linkedin', 'account_user') }} as account_user_history
