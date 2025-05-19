-- Question 2: Transaction Frequency Analysis
-- Calculate the average number of transactions of each customer per month and categorize them by their transaction frequency

-- Calculate the number of transactions monthly 
WITH monthly_transactions AS (
    SELECT 
        s.owner_id,
        COUNT(*) AS transaction_count,
        EXTRACT(MONTH FROM s.transaction_date) AS month,
    FROM 
        savings_savingsaccount s
    GROUP BY 
        s.owner_id, EXTRACT(MONTH FROM s.transaction_date)
),

-- Calculate the average number of transactions
customer_avg AS (
    SELECT 
        owner_id,
        AVG(transaction_count) AS avg_transactions_per_month
    FROM 
        monthly_transactions
    GROUP BY 
        owner_id
)

-- Categorize by frequency
SELECT 
    CASE 
        WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
        WHEN avg_transactions_per_month >= 3 AND avg_transactions_per_month <= 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM 
    customer_avg
GROUP BY 
    frequency_category
ORDER BY 
    CASE 
        WHEN frequency_category = 'High Frequency' THEN 1
        WHEN frequency_category = 'Medium Frequency' THEN 2
        ELSE 3
    END;
