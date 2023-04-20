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

SELECT ID,
       LAST_MODIFIED_TIME,
       CREATED_TIME,
       NAME,
       BACKFILLED,
       STATUS,
       "RUNSCHEDULE_start" as RUN_SCHEDULE_START,
       RUN_SCHEDULE_END,
       ACCOUNT_ID
FROM (SELECT ID,
       LAST_MODIFIED_TIME,
       CREATED_TIME,
       NAME,
       BACKFILLED,
       STATUS,

       {% for column_name in run_schedule_list %}
       RUNSCHEDULE:{{column_name}}::varchar as "RUNSCHEDULE_{{column_name}}"{%- if not loop.last %},{% endif -%}
       {% endfor %},

       RUN_SCHEDULE_END,

       ACCOUNT_ID

FROM {{ source('tap_linkedin', 'campaign_groups') }} as campaign_group_history)
