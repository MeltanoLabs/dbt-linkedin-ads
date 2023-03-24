{{
   config(
     materialized='table'
   )
}}
 
SELECT *
FROM {{ source('tap_linkedin', 'accounts') }} as account_history