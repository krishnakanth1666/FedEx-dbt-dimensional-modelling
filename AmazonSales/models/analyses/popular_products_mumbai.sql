SELECT 
    p.style, 
    p.category, 
    SUM(f.quantity) AS total_quantity_sold,
    SUM(f.sales_amount) AS total_sales_amount
FROM {{ ref('fact_sales') }} f
JOIN {{ ref('dim_product') }} p ON f.product_id = p.product_id
JOIN {{ ref('dim_store') }} s ON f.store_key = s.store_id
WHERE s.ship_city = 'Mumbai'
GROUP BY p.style, p.category
ORDER BY total_quantity_sold DESC
