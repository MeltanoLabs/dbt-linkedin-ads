{{
   config(
     materialized='table'
   )
}}

SELECT ACCOUNT,
       ACCOUNT_ID,
       ALLOWED_CAMPAIGN_TYPES,
       BACKFILLED,
       CHANGE_AUDIT_STAMPS,
       CREATED_TIME,
       ID,
       LAST_MODIFIED_TIME,
       NAME,
       RUN_SCHEDULE,
       SERVING_STATUSES,
       STATUS,
       TEST,
       TOTAL_BUDGET
FROM {{ source('tap_linkedin', 'campaign_groups') }} as campaign_group_history
