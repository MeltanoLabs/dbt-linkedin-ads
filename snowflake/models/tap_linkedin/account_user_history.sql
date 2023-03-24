{{
   config(
     materialized='table'
   )
}}

SELECT ACCOUNT,
       ACCOUNT_ID, 
       CAMPAIGN_CONTACT,
       CHANGE_AUDIT_STAMPS,
       CREATED_TIME,
       LAST_MODIFIED_TIME,
       ROLE,
       USER,
       USER_PERSON_ID
FROM {{ source('tap_linkedin', 'account_users') }} as account_users_history
