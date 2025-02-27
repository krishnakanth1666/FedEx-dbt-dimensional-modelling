{{ config(
    materialized='table'
    ) 
}}

WITH product_data AS (
    SELECT DISTINCT
        {{ dbt_utils.generate_surrogate_key(['sku']) }} as product_id,
        sku,
        category,
        style,
        size
    FROM {{ ref('stg_sales') }}
)

SELECT 
    *
FROM product_data

