{{
   config(
     materialized='table'
   )
}}

SELECT ACCOUNT,
       ACCOUNT_ID,
       CHANGE_AUDIT_STAMPS,
       CONTENT_REFERENCE,
       CONTENT_REFERENCE_SHARE_ID,
       CONTENT_REFERENCE_UCG_POST_ID,
       CREATED_TIME,
       LAST_MODIFIED_TIME,
       NAME,
       OWNER,
       OWNER_ORGANIZATION_ID,
       TYPE
FROM {{ source('tap_linkedin', 'video_ads') }} as video_ads
