{{ config(materialized='table') }}

WITH fulfillment AS (
    SELECT DISTINCT
        CONCAT(ship_service_level, '-', status) AS fulfillment_id,
        fulfillment_type,
        ship_service_level,
        status
    FROM {{ ref('stg_sales') }}
)

SELECT * FROM fulfillment
