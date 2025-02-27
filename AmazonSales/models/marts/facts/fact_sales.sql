WITH sales_data AS (
    SELECT DISTINCT
        {{ dbt_utils.generate_surrogate_key(['order_id']) }} as sales_id,
        {{ dbt_utils.generate_surrogate_key(['order_date']) }} as date_id,
        {{ dbt_utils.generate_surrogate_key(['sku']) }} as product_key,
        CONCAT(ship_service_level, '-', status) AS fulfillment_key,
        promotion_ids AS promotion_key,
        {{ dbt_utils.generate_surrogate_key(['fulfilled_by','ship_city','ship_state','courier_status']) }} as store_key,
        qty AS quantity,
        amount AS sales_amount,
        currency,
        ship_country AS country,
        fulfilled_by AS fulfillment_type,
        ship_city,
        ship_state
    FROM {{ ref('stg_sales') }}
),

final_fact AS (
    SELECT DISTINCT
        s.sales_id,
        s.date_id,
        p.product_id,
        s.store_key,
        pr.promotion_id,
        f.fulfillment_id,
        d.order_date,
        s.quantity,
        s.sales_amount,
        s.currency,
        s.country,
        s.ship_city,
        s.ship_state
    FROM sales_data s
    LEFT JOIN {{ ref('dim_date') }} d ON s.date_id = d.date_key
    LEFT JOIN {{ ref('dim_product') }} p ON s.product_key = p.product_id
    LEFT JOIN {{ ref('dim_store') }} st ON s.store_key = st.store_id
    LEFT JOIN {{ ref('dim_promotion') }} pr ON s.promotion_key = pr.promotion_id
    LEFT JOIN {{ ref('dim_fulfillment') }} f ON s.fulfillment_key = f.fulfillment_id
)

SELECT * FROM final_fact
