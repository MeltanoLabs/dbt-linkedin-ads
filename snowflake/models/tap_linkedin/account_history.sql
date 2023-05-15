{% set json_column_query %}
select distinct json.key as column_name

FROM {{ source('tap_linkedin', 'account') }},

lateral flatten(input=>VERSION) json
{% endset %}

{% set version_results = run_query(json_column_query) %}

{% if execute %}
    {# Return the first column #}
    {% set version_list = version_results.columns[0].values() %}
{% else %}
{% set version_list = [] %}
{% endif %}

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


    {% for column_name in version_list %}
        version:"versionTag"::varchar AS version_tag{%- if not loop.last %}
            
            
            ,
        
        
        {% endif -%}
    {% endfor %},

    _sdc_batched_at

FROM {{ source('tap_linkedin', 'account') }}
