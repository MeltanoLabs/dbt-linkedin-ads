{{
   config(
     materialized='view'
   )
}}

SELECT
    id,
    last_modified_time,
    created_time,
    name,
    backfilled,
    status,
    run_schedule_start,
    run_schedule_end,
    account_id,
    _sdc_batched_at

FROM {{ source('tap_linkedin', 'campaign_groups') }}
