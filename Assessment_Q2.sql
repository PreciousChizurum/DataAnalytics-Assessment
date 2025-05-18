-- Question 2: Transaction Frequency Analysis
-- Calculate the average number of transactions per customer per month and categorize them by their transaction frequency

WITH monthly_transactions AS (
    SELECT 
        s.owner_id,
        COUNT(*) AS transaction_count,
        COUNT(DISTINCT DATE_TRUNC('month', s.created_at)) AS months_active
    FROM 
        savings_savingsaccount s
    WHERE 
        s.confirmed_amount > 0  -- Only count actual transactions
    GROUP BY 
        s.owner_id
),
frequency_analysis AS (
    SELECT 
        owner_id,
        CASE 
            WHEN transaction_count/months_active >= 10 THEN 'High Frequency'
            WHEN transaction_count/months_active >= 3 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        transaction_count/months_active AS avg_transactions_per_month
    FROM 
        monthly_transactions
)
SELECT 
    frequency_category,
    COUNT(owner_id) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM 
    frequency_analysis
GROUP BY 
    frequency_category
ORDER BY 
    CASE 
        WHEN frequency_category = 'High Frequency' THEN 1
        WHEN frequency_category = 'Medium Frequency' THEN 2
        ELSE 3
    END;
