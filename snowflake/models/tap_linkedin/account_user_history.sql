{{
   config(
     materialized='view'
   )
}}

SELECT
    account_id,
    user_person_id AS id,
    last_modified_time,
    role,
    created_time,
    _sdc_batched_at

FROM {{ source('tap_linkedin', 'account_user') }}
