{{ config(
    materialized='table'
    ) 
}}

WITH stores AS (
    SELECT DISTINCT
        {{ dbt_utils.generate_surrogate_key(['fulfilled_by','ship_city','ship_state','courier_status']) }} as store_id,
        fulfilled_by,
        ship_city,
        ship_state,
        courier_status
    FROM {{ ref('stg_sales') }}
    WHERE fulfilled_by is not null
)

SELECT * FROM stores
