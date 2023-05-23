# dbt-linkedin-ads

<p align="center">
    <a alt="License"
        href="https://github.com/MeltanoLabs/dbt-linkedin-ads/blob/main/LICENSE">
        <img src="https://img.shields.io/badge/MIT-blue.svg" /></a>
    <a alt="dbt-core">
        <img src="https://img.shields.io/badge/dbt_Core™_version->=1.3.0_,<2.0.0-orange.svg" /></a>
    <a alt="Maintained?">
        <img src="https://img.shields.io/badge/Maintained%3F-yes-green.svg" /></a>
    <a alt="PRs">
        <img src="https://img.shields.io/badge/Contributions-welcome-blueviolet" /></a>
</p>

# Linkedin Ads Meltano tap data transformation for dbt

This package is designed to work alongside the [Linkedin Ads tap](https://github.com/MeltanoLabs/tap-linkedin-ads) to transform the data into an easy-to-use format.

Supported warehouses:

- Snowflake

## Installation and use

1. Include the following package version in your `packages.yml` file. Check [dbt Hub](https://hub.getdbt.com/) for the latest version to use.

```yml
packages:
    - package: meltano/linkedin_ads # TBC
      version: 0.1.0 # TBC
```

2. Install the package by running `dbt deps`

3. In your `dbt_project.yml` file, include the locations where the tap data is expected to load from:

```yml
vars:
  linkedin_ads_database: your_database_name
  linkedin_ads_schema: your_database_schema # By default this is `tap_linkedin_ads`
```

4. Choose which schemas you want to build the tables in by including this in your `dbt_project.yml` file:

```yml
models:
  dbt_linkedin_ads:
    marts:
      +schema: your_marts_schema
    staging:
      +schema: your_staging_schema
```

5. Build the tables by running

```sh
dbt run --select package:dbt_linkedin_ads
```

## Tables

These are the tables that will be built with this project.

| Table | Description |
| ----- | ----------- |
| account_history | TODO |
| account_serving_status_history | TODO |
| account_user_history | TODO |
| ad_analytics_by_campaign | TODO |
| ad_analytics_by_creative | TODO |
| campaign_group_history | TODO |
| campaign_group_serving_status_history | TODO |
| campaign_history | TODO |
| campaign_serving_status_history | TODO |
| creative_history | TODO |
| creative_serving_status_history | TODO |

## Contributing

Want to get involved? Please do! Feel free to create your own fork and create PRs with updates. If you aren't sure how to get started, then please reach out to one of the maintainers, and we'd be happy to help.

Spot something amiss? Please create an issue on [GitHub](https://github.com/MeltanoLabs/dbt-linkedin-ads/issues).

## SQLFluff Linting

This repo has SQLFluff configured for linting.
See https://docs.sqlfluff.com/en/stable/index.html for more details.

Install SQLFluff into a virtualenv and export the required profile env vars needed to connect to the warehouse.

```bash
# Install SQLFluff and dbt
pip install sqlfluff==2.0.3 sqlfluff-templater-dbt==2.0.3 dbt-core~=1.3.0 dbt-snowflake~=1.3.0

# Export env vars needed for dbt
export DBT_SNOWFLAKE_ACCOUNT=<>
export DBT_SNOWFLAKE_USER=<>
export DBT_SNOWFLAKE_PASSWORD=<>
export DBT_SNOWFLAKE_ROLE=<>
export DBT_SNOWFLAKE_WAREHOUSE=<>
export DBT_SNOWFLAKE_DATABASE=<>
export DBT_SNOWFLAKE_SCHEMA=<>

# Run SQLFluff against the models
sqlfluff lint models/
sqlfluff fix models/
```
