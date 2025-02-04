{{ config(
    materialized='table'
) }}

WITH sales_data AS (
    SELECT 
        o.OrderID,       
        o.CustomerID,
        c.CustomerName,
        o.ProductID,
        p.ProductName,
        p.Category,
        o.Quantity,
        p.Price,
        (o.Quantity * p.Price) AS TotalSales,
        o.OrderDate
    FROM {{ source('sales', 'orders') }} o
    LEFT JOIN {{ source('sales', 'customers') }} c ON o.CustomerID = c.CustomerID
    LEFT JOIN {{ source('sales', 'products') }} p ON o.ProductID = p.ProductID
)

SELECT * FROM sales_data;
