{{
   config(
     materialized='view'
   )
}}

{% set json_column_query %}
select distinct json.key as column_name

FROM {{ source('tap_linkedin', 'account')}},

lateral flatten(input=>VERSION) json
{% endset %}
 
{% set version_results = run_query(json_column_query) %}

{% if execute %}
{# Return the first column #}
{% set version_list = version_results.columns[0].values() %}
{% else %}
{% set version_list = [] %}
{% endif %}
 
SELECT ID,
       LAST_MODIFIED_TIME,
       CREATED_TIME,
       NOTIFIEDONCREATIVEAPPROVAL as NOTIFIED_ON_CREATIVE_APPROVAL,
       NOTIFIEDONCREATIVEREJECTION as NOTIFIED_ON_CREATIVE_REJECTION,
       NOTIFIEDONCAMPAIGNOPTIMIZATION as NOTIFIED_ON_CAMPAIGN_OPTIMIZATION,
       NOTIFIEDONENDOFCAMPAIGN as NOTIFIED_ON_END_OF_CAMPAIGN,
       REFERENCE,
       NAME,
       CURRENCY,
       STATUS,
       TYPE,
       _SDC_BATCHED_AT,


{% for column_name in version_list %}
VERSION:{{column_name}}::varchar as "VERSION_TAG"{%- if not loop.last %},{% endif -%}
{% endfor %}

FROM {{ source('tap_linkedin', 'account') }} as account_history
