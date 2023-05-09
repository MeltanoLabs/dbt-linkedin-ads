# dbt-facebook-meltano-sdk


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
sqlfluff lint Snowflake/models/
sqlfluff fix Snowflake/models/
```


