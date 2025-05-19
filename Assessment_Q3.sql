-- Question 3: Account Inactivity Alert
-- Query to find all active accounts (savings or investments) with no transactions in the last 1 year

WITH latest_transactions AS (
    SELECT 
        owner_id,
        account_type,
        MAX(transaction_date) AS last_transaction_date
    FROM (
        -- Savings plan
        SELECT owner_id, 'savings' AS account_type, transaction_date 
        FROM savings_savingsaccount 
        WHERE confirmed_amount > 0
        
        UNION ALL
        
        -- Investment plans
        SELECT owner_id, 'investment' AS account_type, created_on AS transaction_date
        FROM plans_plan 
        WHERE is_a_fund = 1 AND amount > 0
    ) AS combined_transactions
    GROUP BY owner_id, account_type
)

SELECT 
    owner_id AS customer_id,
    account_type,
    last_transaction_date,
    CURRENT_DATE - last_transaction_date AS inactivity_days
FROM latest_transactions
WHERE CURRENT_DATE - last_transaction_date > 365
ORDER BY inactivity_days DESC;
