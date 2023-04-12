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
       VERSION_TAG,


{% for column_name in daily_budget_list %}
DAILYBUDGET:{{column_name}}::varchar as {{column_name}}{%- if not loop.last %},{% endif -%}
{% endfor %}       

FROM {{ source('tap_linkedin', 'campaign') }} as campaign_history
