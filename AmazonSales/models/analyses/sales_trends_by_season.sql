SELECT 
    CASE 
    WHEN d.order_month IN (12, 1, 2) THEN 'Winter'
    WHEN d.order_month IN (3, 4, 5) THEN 'Summer'
    WHEN d.order_month IN (6, 7, 8, 9) THEN 'Monsoon'
    ELSE 'Autumn'
END AS season, 
    SUM(f.sales_amount) AS total_sales_amount,
    COUNT(DISTINCT f.sales_id) AS total_orders
FROM {{ ref('fact_sales') }} f
JOIN {{ ref('dim_date') }} d ON f.order_date = d.order_date
GROUP BY season
ORDER BY total_sales_amount DESC
