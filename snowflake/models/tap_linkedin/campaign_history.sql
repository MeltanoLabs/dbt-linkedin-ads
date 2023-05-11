{% set json_column_query %}
select distinct json.key as column_name

FROM {{ source('tap_linkedin', 'campaign') }},

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

FROM {{ source('tap_linkedin', 'campaign') }},

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

FROM {{ source('tap_linkedin', 'campaign') }},

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

FROM {{ source('tap_linkedin', 'campaign') }},

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
    type,
    objectivetype AS objective_type,
    associatedentity AS associated_entity,
    optimizationtargettype AS optimization_target_type,
    costtype AS cost_type,
    creativeselection AS creative_selection,
    name,
    offsitedeliveryenabled AS offsite_delivery_enabled,
    audienceexpansionenabled AS audience_expansion_enabled,
    status,
    format,

    {% for column_name in locale_list %}
        locale:{{ column_name }}::varchar AS locale_{{ column_name }}{%- if not loop.last %}        

            ,
        
        {% endif -%}
    {% endfor %},

    run_schedule_start,
    run_schedule_end,

    {% for column_name in version_list %}
        version:{{ column_name }}::varchar AS version_tag{%- if not loop.last %}
            
            ,
        
        {% endif -%}
    {% endfor %},


    dailybudget:amount::varchar AS daily_budget_amount,
    dailybudget:currencyCode::varchar AS daily_budget_currency_code
    ,

    unitcost:amount::varchar AS unit_cost_amount,
    unitcost:currencyCode::varchar AS unit_cost_currency_code

    ,

    campaign_group_id,
    account_id,
    _sdc_batched_at


FROM {{ source('tap_linkedin', 'campaign') }}
