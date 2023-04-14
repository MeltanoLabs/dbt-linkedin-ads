{{
   config(
     materialized='table'
   )
}}

{% set json_column_query %}
select distinct json.key as column_name

FROM {{ source('tap_linkedin', 'campaign_groups')}},

lateral flatten(input=>RUNSCHEDULE) json
{% endset %}
 
{% set run_schedule_results = run_query(json_column_query) %}

{% if execute %}
{# Return the first column #}
{% set run_schedule_list = run_schedule_results.columns[0].values() %}
{% else %}
{% set run_schedule_list = [] %}
{% endif %}

SELECT ACCOUNT,
       ACCOUNT_ID,
       ALLOWED_CAMPAIGN_TYPES,
       BACKFILLED,
       CHANGEAUDITSTAMPS,
       CREATED_TIME,
       ID,
       LAST_MODIFIED_TIME
       NAME,
       RUNSCHEDULE,
       SERVINGSTATUSES,
       STATUS,
       TEST,
       TOTAL_BUDGET,


{% for column_name in run_schedule_list %}
RUNSCHEDULE:{{column_name}}::varchar as "RUNSCHEDULE_{{column_name}}"{%- if not loop.last %},{% endif -%}
{% endfor %}

FROM {{ source('tap_linkedin', 'campaign_groups') }} as campaign_group_history
