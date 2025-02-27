{{ config(
    materialized='table'
    ) 
}}

WITH dates AS (
    SELECT DISTINCT 
        {{ dbt_utils.generate_surrogate_key(['order_date']) }} as date_key,
        order_date,
        EXTRACT(MONTH FROM order_date) AS order_month,
        TO_CHAR(order_date, 'Month') AS order_month_name,
        EXTRACT(YEAR FROM order_date) AS order_year,
        EXTRACT(QUARTER FROM order_date) AS order_quarter
    FROM {{ ref('stg_sales') }}
)

SELECT * FROM dates
