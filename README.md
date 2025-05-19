# Question 1

- I started with the FROM statement. Then, the JOIN statement. I joined the users table with both savings and plans tables. I chose to use JOIN because I wanted to ensure that only the customers with both a savings plan and an investment plan are considered. The hint mentioned that “owner_id” is a foreign key to the ID primary key in the users table. I used it to link the savings to users and the plans to users as well while filtering for funded accounts. I also gave these tables aliases to make it easier for me and to enhance readability. So, “u” refers to the users table, “s” refers to the savings table and “p” refers to the plans table.

- Then, GROUP BY statement was used to group results by customer Id, first name and last name (assuming there is a first and last name column).

- ⁠At this point, I added the SELECT statement. I renamed “u.id” to “owner_id”. The columns were named according to the column names in the expected output. I used CONCAT because the name column in the expected output has both first and last name. It is common for user tables in databases to store names separately. So, I assumed the names here are stored separately too. I added columns for the counts of the funded savings plan and investment plan of each customer. Then, I converted the sum of the amounts from kobo to naira because the expected output is in naira (1 naira = 100 kobo, hence the division).

- Lastly, I used the ORDER BY statement to sort by total deposits. I sorted it by descending order so that the highest deposits come first.


# Question 2

- I wrote the query for this question in steps. I created temporary named result sets or CTE using the WITH statement because the query is long and complicated. Firstly, I calculated the number of transactions by each customer monthly.
  
- ⁠Also, I calculated the average number of transactions of each customer per month.
  
- ⁠Then, I categorized their average number of transactions into different frequency levels according to the metrics given in the question. I went further to create 2 columns; one for the count of customers and the other  for the average of the average transactions (rounded to 1 decimal place) in each frequency category.
  
- ⁠I decided to order it the way I did because I wanted it appear exactly as seen in the expected output.


## Question 3

- I started by joining both the savings and plans table using UNION ALL. I included ‘savings’ and ‘investment’ for account type so that it will be easier to identify which account is inactive; whether it is the savings or investment account. I also filtered this to funded savings/investment accounts to only 

- ⁠Then, I used WITH to create a CTE that groups lastest transactions by owner_id and account type. I used MAX because it identifies the lastest transaction date for each account. 

- ⁠Lastly, I calculated the inactivity period by subtracting last transaction date from current date and filtered the results in order to know the accounts with more than 365 days of activity.


## Question 4

- I started by joining the users and savings table and grouping. 

- Then, I created a CTE (using WITH) that calculates Tenure in months, Total transactions and Total transaction value in naira. 

- ⁠ I estimated the CLV and rounded to 2 decimal places. To get the CLV, I decide the total transactions by the tenure. Then, I multiplied by the 12 months of the year. After which, I multiply by 0.1% of the average transaction value (0.1% profit assumption). I ordered it from the highest to the lowest. 

Formula
CLV = (transactions / tenure) × 12 × (0.1% of avg_transaction_value)
