SELECT
    id AS account_id,
    last_modified_time AS account_last_modified_time,
    status,
    _sdc_batched_at

FROM {{ source('tap_linkedin', 'account') }}
