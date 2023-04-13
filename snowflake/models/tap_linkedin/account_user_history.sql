{{
   config(
     materialized='table'
   )
}}

SELECT ACCOUNT,
       ACCOUNT_ID,
       CAMPAIGN_CONTACT,
       CHANGEAUDITSTAMPS,
       CREATED_TIME,
       LAST_MODIFIED_TIME,
       ROLE,
       USER,
       USER_PERSON_ID

FROM {{ source('tap_linkedin', 'account_user') }} as account_user_history
