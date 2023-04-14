{{
   config(
     materialized='table'
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
 
SELECT CHANGEAUDITSTAMPS,
       CREATED_TIME,
       CURRENCY,
       ID,
       LAST_MODIFIED_TIME,
       NAME,
       NOTIFIEDONCAMPAIGNOPTIMIZATION,
       NOTIFIEDONCREATIVEAPPROVAL,
       NOTIFIEDONCREATIVEREJECTION,
       NOTIFIEDONENDOFCAMPAIGN,
       NOTIFIEDONNEWFEATURESENABLED,
       REFERENCE,
       REFERENCE_ORGANIZATION_ID,
       REFERENCE_PERSON_ID,
       SERVINGSTATUSES,
       STATUS,
       TEST,
       TOTAL_BUDGET,
       TOTAL_BUDGET_ENDS_AT,
       TYPE,
       VERSION,


{% for column_name in version_list %}
VERSION:{{column_name}}::varchar as {{column_name}}{%- if not loop.last %},{% endif -%}
{% endfor %}

FROM {{ source('tap_linkedin', 'account') }} as account_history
