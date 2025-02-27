{{ config(materialized='table') }}

WITH promotions AS (
    SELECT DISTINCT
        promotion_ids AS promotion_id
    FROM {{ ref('stg_sales') }}
    WHERE promotion_ids is NOT NULL
)

SELECT * FROM promotions
