{{
   config(
     materialized='table'
   )
}}

SELECT ID,
       LAST_MODIFIED_TIME,
       CREATED_TIME,
       NAME,
       BACKFILLED,
       STATUS,
       RUN_SCHEDULE_START,
       RUN_SCHEDULE_END,
       ACCOUNT_ID
FROM (SELECT ID,
       LAST_MODIFIED_TIME,
       CREATED_TIME,
       NAME,
       BACKFILLED,
       STATUS,

       RUN_SCHEDULE_START,
       RUN_SCHEDULE_END,

       ACCOUNT_ID,
       _SDC_BATCHED_AT

FROM {{ source('tap_linkedin', 'campaign_groups') }} as campaign_group_history)
