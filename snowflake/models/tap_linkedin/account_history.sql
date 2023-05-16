SELECT
    id,
    last_modified_time,
    created_time,
    notifiedoncreativeapproval AS notified_on_creative_approval,
    notifiedoncreativerejection AS notified_on_creative_rejection,
    notifiedoncampaignoptimization AS notified_on_campaign_optimization,
    notifiedonendofcampaign AS notified_on_end_of_campaign,
    reference,
    name,
    currency,
    status,
    type,
    version:"versionTag"::varchar AS version_tag,
    _sdc_batched_at

FROM {{ source('tap_linkedin', 'account') }}
