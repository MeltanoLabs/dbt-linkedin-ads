{{
   config(
     materialized='table'
   )
}}

SELECT *
FROM {{ source('tap_linkedin', 'account_users') }} as account_users_history