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

SELECT ID,
       LAST_MODIFIED_TIME,
       CREATED_TIME,
       TYPE,
       OBJECTIVETYPE as OBJECTIVE_TYPE,
       ASSOCIATEDENTITY as ASSOCIATED_ENTITY,
       OPTIMIZATIONTARGETTYPE as OPTIMIZATION_TARGET_TYPE,
       COSTTYPE as COST_TYPE,
       CREATIVESELECTION as CREATIVE_SELECTION,
       NAME,
       OFFSITEDELIVERYENABLED as OFFSITE_DELIVERY_ENABLED,
       AUDIENCEEXPANSIONENABLED as AUDIENCE_EXPANSION_ENABLED,
       STATUS,
       FORMAT,
       COUNTRY as LOCALE_COUNTRY,
       LANGUAGE as LOCALE_LANGUAGE,
       RUN_SCHEDULE_START,
       RUN_SCHEDULE_END,
       VERSIONTAG as VERSION_TAG,
       "DAILYBUDGET_amount" as DAILY_BUDGET_AMOUNT,
       "DAILYBUDGET_currencyCode" as DAILY_BUDGET_CURRENCY_CODE,
       "UNITCOST_amount" as UNIT_COST_AMOUNT,
       "UNITCOST_currencyCode" as UNIT_COST_CURRENCY_CODE,
       CAMPAIGN_GROUP_ID,
       ACCOUNT_ID
FROM (SELECT ID,
       LAST_MODIFIED_TIME,
       CREATED_TIME,
       TYPE,
       OBJECTIVETYPE,
       ASSOCIATEDENTITY,
       OPTIMIZATIONTARGETTYPE,
       COSTTYPE,
       CREATIVESELECTION,
       NAME,
       OFFSITEDELIVERYENABLED,
       AUDIENCEEXPANSIONENABLED,
       STATUS,
       FORMAT,

       {% for column_name in locale_list %}
       LOCALE:{{column_name}}::varchar as {{column_name}}{%- if not loop.last %},{% endif -%}
       {% endfor %},

       RUN_SCHEDULE_START,
       RUN_SCHEDULE_END,
       
       {% for column_name in version_list %}
       VERSION:{{column_name}}::varchar as {{column_name}}{%- if not loop.last %},{% endif -%}
       {% endfor %},

       {% for column_name in daily_budget_list %}
       DAILYBUDGET:{{column_name}}::varchar as "DAILYBUDGET_{{column_name}}"{%- if not loop.last %},{% endif -%}
       {% endfor %},

       {% for column_name in unit_cost_list %}
       UNITCOST:{{column_name}}::varchar as "UNITCOST_{{column_name}}"{%- if not loop.last %},{% endif -%}
       {% endfor %},

      CAMPAIGN_GROUP_ID,
      ACCOUNT_ID
       

FROM {{ source('tap_linkedin', 'campaign') }} as campaign_history)
