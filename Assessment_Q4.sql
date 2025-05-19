-- Question 4: Customer Lifetime Value (CLV) Estimation

-- Calculate Tenure in months, Total transactions and Total transaction value
WITH customer_stats AS (
    SELECT 
        u.id AS customer_id,
        CONCAT(u.first_name, ' ', u.last_name) AS name,
        EXTRACT(MONTH FROM AGE(CURRENT_DATE, u.date_joined)) AS tenure_months, -- Account tenure in months
        COUNT(s.id) AS total_transactions, -- Total transactions count
        SUM(s.confirmed_amount) / 100 AS total_transaction_value --To convert total transaction value from kobo to naira
    FROM 
        users_customuser u
    LEFT JOIN 
        savings_savingsaccount s ON u.id = s.owner_id
    GROUP BY 
        u.id, u.first_name, u.last_name, u.date_joined
)

SELECT 
    customer_id,
    name,
    tenure_months,
    total_transactions,
    ROUND(
        (total_transactions / NULLIF(tenure_months, 0)) * 12 * 
        (0.001 * total_transaction_value / NULLIF(total_transactions, 0)),
        2
    ) AS estimated_clv -- CLV calculation
FROM 
    customer_stats
ORDER BY 
    estimated_clv DESC;
