{{
   config(
     materialized='view'
   )
}}

SELECT
    id,
    last_modified_at,
    call_to_action,
    click_uri,
    reference,
    follower_logo,
    follower_show_member_profile_photo,
    follower_organization_name,
    text_ad_headline,
    text_ad_description,
    text_ad_image,
    jobs_organization_name,
    jobs_logo,
    jobs_show_member_profile_photo,
    spotlight_description,
    spotlight_headline,
    spotlight_logo,
    spotlight_organization_name,
    spotlight_show_member_profile_photo,
    created_at,
    created_by,
    intended_status,
    inline_content,
    is_serving,
    last_modified_by,
    review_status,
    campaign_id,
    account_id,
    _sdc_batched_at

FROM {{ source('tap_linkedin', 'creatives') }}
