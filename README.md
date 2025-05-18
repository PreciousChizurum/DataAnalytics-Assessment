# Question 1

- I started with the FROM statement. Then, the LEFT JOIN statement. I joined the users table with both savings and plans tables. I chose to use LEFT JOIN because I wanted to ensure that all the customers in the users table are considered and then filter it later. The hint mentioned that “owner_id” is a foreign key to the ID primary key in the users table. I used it to link the savings to users and the investment plan to users as well. I also gave these tables aliases to make it easier for me and to enhance readability. So, “u” refers to the users table, “s” refers to the savings table and “p” refers to the plans table.

- To the SELECT statement, I renamed “u.id” to “owner_id”. The columns were named according to the column names in the expected output. I used CONCAT because the name column in the expected output has both first and last name.  It is common for user tables in databases to store names separately. So, I assumed the names here are stored separately too. I added columns for the counts of the funded savings plan and investment plan. Lastly, I converted the amounts from kobo to naira because the expected output is in naira (1 naira = 100 kobo, hence the division).

- I used the WHERE statement to filter out unfunded savings accounts and customers with without an investment plan

- GROUP BY statement was used to group results by customer (assuming there is a first and last name column).

- Lastly, I used the ORDER BY statement to sort by total deposits. I sorted it by descending order so that the highest deposits come first.
