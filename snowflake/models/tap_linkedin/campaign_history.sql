{{
   config(
     materialized='table'
   )
}}

{% set json_column_query %}
select distinct json.key as column_name

FROM {{ source('tap_linkedin', 'campaign')}},

lateral flatten(input=>DAILYBUDGET) json
{% endset %}
 
{% set daily_budget_results = run_query(json_column_query) %}

{% if execute %}
{# Return the first column #}
{% set daily_budget_list = daily_budget_results.columns[0].values() %}
{% else %}
{% set daily_budget_list = [] %}
{% endif %}

{% set json_column_query %}
select distinct json.key as column_name

FROM {{ source('tap_linkedin', 'campaign')}},

lateral flatten(input=>LOCALE) json
{% endset %}
 
{% set locale_results = run_query(json_column_query) %}

{% if execute %}
{# Return the first column #}
{% set locale_list = locale_results.columns[0].values() %}
{% else %}
{% set locale_list = [] %}
{% endif %}

{% set json_column_query %}
select distinct json.key as column_name

FROM {{ source('tap_linkedin', 'campaign')}},

lateral flatten(input=>OFFSITEPREFERENCES) json
{% endset %}
 
{% set offsite_preferences_results = run_query(json_column_query) %}

{% if execute %}
{# Return the first column #}
{% set offsite_preferences_list = offsite_preferences_results.columns[0].values() %}
{% else %}
{% set offsite_preferences_list = [] %}
{% endif %}

{% set json_column_query %}
select distinct json.key as column_name

FROM {{ source('tap_linkedin', 'campaign')}},

lateral flatten(input=>RUNSCHEDULE) json
{% endset %}
 
{% set run_schedule_results = run_query(json_column_query) %}

{% if execute %}
{# Return the first column #}
{% set run_schedule_list = run_schedule_results.columns[0].values() %}
{% else %}
{% set run_schedule_list = [] %}
{% endif %}

{% set json_column_query %}
select distinct json.key as column_name

FROM {{ source('tap_linkedin', 'campaign')}},

lateral flatten(input=>TARGETINGCRITERIA) json
{% endset %}
 
{% set targeting_criteria_results = run_query(json_column_query) %}

{% if execute %}
{# Return the first column #}
{% set targeting_criteria_list = targeting_criteria_results.columns[0].values() %}
{% else %}
{% set targeting_criteria_list = [] %}
{% endif %}

{% set json_column_query %}
select distinct json.key as column_name

FROM {{ source('tap_linkedin', 'campaign')}},

lateral flatten(input=>UNITCOST) json
{% endset %}
 
{% set unit_cost_results = run_query(json_column_query) %}

{% if execute %}
{# Return the first column #}
{% set unit_cost_list = unit_cost_results.columns[0].values() %}
{% else %}
{% set unit_cost_list = [] %}
{% endif %}

{% set json_column_query %}
select distinct json.key as column_name

FROM {{ source('tap_linkedin', 'campaign')}},

lateral flatten(input=>VERSION) json
{% endset %}
 
{% set version_results = run_query(json_column_query) %}

{% if execute %}
{# Return the first column #}
{% set version_list = version_results.columns[0].values() %}
{% else %}
{% set version_list = [] %}
{% endif %}


SELECT ACCOUNT,
       ACCOUNT_ID,
       ASSOCIATEDENTITY,
       ASSOCIATED_ENTITY_ORGANIZATION_ID,
       ASSOCIATED_ENTITY_PERSON_ID,
       AUDIENCEEXPANSIONENABLED,
       CAMPAIGNGROUP,
       CAMPAIGN_GROUP_ID,
       CHANGEAUDITSTAMPS,
       COSTTYPE,
       CREATIVESELECTION,
       DAILYBUDGET,
       FORMAT,
       ID,
       LOCALE,
       NAME,
       OBJECTIVETYPE,
       OFFSITEDELIVERYENABLED,
       OFFSITEPREFERENCES,
       OPTIMIZATIONTARGETTYPE,
       PACINGSTRATEGY,
       RUNSCHEDULE,
       SERVINGSTATUSES,
       STATUS,
       STORYDELIVERYENABLED,
       TARGETING,
       TARGETINGCRITERIA,
       TEST,
       TOTALBUDGET,
       TYPE,
       UNITCOST,
       VERSION,


{% for column_name in daily_budget_list %}
DAILYBUDGET:{{column_name}}::varchar as {{column_name}}{%- if not loop.last %},{% endif -%}
{% endfor %},

{% for column_name in locale_list %}
LOCALE:{{column_name}}::varchar as {{column_name}}{%- if not loop.last %},{% endif -%}
{% endfor %},

{% for column_name in offsite_preferences_list %}
OFFSITEPREFERENCES:{{column_name}}::varchar as {{column_name}}{%- if not loop.last %},{% endif -%}
{% endfor %},

{% for column_name in run_schedule_list %}
RUNSCHEDULE:{{column_name}}::varchar as "RUNSCHEDULE_{{column_name}}"{%- if not loop.last %},{% endif -%}
{% endfor %},

{% for column_name in targeting_criteria_list %}
TARGETINGCRITERIA:{{column_name}}::varchar as {{column_name}}{%- if not loop.last %},{% endif -%}
{% endfor %},

{% for column_name in unit_cost_list %}
UNITCOST:{{column_name}}::varchar as "UNITCOST_{{column_name}}"{%- if not loop.last %},{% endif -%}
{% endfor %},

{% for column_name in version_list %}
VERSION:{{column_name}}::varchar as {{column_name}}{%- if not loop.last %},{% endif -%}
{% endfor %}

FROM {{ source('tap_linkedin', 'campaign') }} as campaign_history
