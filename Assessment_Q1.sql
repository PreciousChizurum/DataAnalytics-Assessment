-- Question 1: High-Value Customers with Multiple Products
-- Query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits

SELECT 
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    COUNT(DISTINCT s.id) AS savings_count,
    COUNT(DISTINCT p.id) AS investment_count,
    (SUM(s.confirmed_amount) + SUM(p.amount)) / 100 AS total_deposits -- To convert both amounts from kobo to naira
FROM 
    users_customuser u
JOIN 
    savings_savingsaccount s ON u.id = s.owner_id AND s.confirmed_amount > 0
JOIN 
    plans_plan p ON u.id = p.owner_id AND p.is_a_fund = 1 AND p.amount > 0
GROUP BY 
    u.id, u.first_name, u.last_name
ORDER BY 
    total_deposits DESC;
