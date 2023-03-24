{{
   config(
     materialized='table'
   )
}}

SELECT *
FROM {{ source('tap_linkedin', 'campaigns') }} as campaign_history
