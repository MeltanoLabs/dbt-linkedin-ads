SELECT
    id AS campaign_id,
    last_modified_time AS campaign_last_modified_time,
    status,
    _sdc_batched_at

FROM {{ source('tap_linkedin', 'campaign') }}
