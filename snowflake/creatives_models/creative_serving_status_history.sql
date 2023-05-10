{{
   config(
     materialized='view'
   )
}}

SELECT
    id AS creative_id,
    last_modified_time AS creative_last_modified_time,
    status,
    _sdc_batched_at

FROM {{ source('tap_linkedin', 'creatives') }}
