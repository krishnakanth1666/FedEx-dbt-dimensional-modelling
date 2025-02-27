{{ config(materialized='view') }}

WITH cleaned_sales AS (
    SELECT
        order_id,
        TO_DATE(order_date, 'MM-DD-YY') AS order_date,
        "SKU" AS sku,
        "ship-city" AS ship_city,
        "ship-state" AS ship_state,
        "ship-postal-code" AS ship_postal_code,
        "ship-country" AS ship_country,
        "fulfilled-by" AS fulfilled_by,
        "Fulfilment" AS fulfillment_type,
        "ship-service-level" AS ship_service_level,
        "Status" AS status,
        "Courier Status" AS courier_status,
        "promotion-ids" AS promotion_ids,
        "Qty"::INTEGER AS qty,
        "Amount"::NUMERIC AS amount,
        currency,
        "Category" AS category,
        "Style" AS style,
        "Size" AS size,
        "ASIN" AS asin,
        sales_channel
    FROM {{ source('sales_dbo', 'Amazon Sale Report') }}
)

SELECT * FROM cleaned_sales
