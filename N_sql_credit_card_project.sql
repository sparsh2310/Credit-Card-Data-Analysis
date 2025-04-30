create database credit_card_db;

-- dataset : https://drive.google.com/drive/folders/1epR5h9QF7PbMwH7G28NNiHOkhgnVxBco

select * from credit_card_db.credit_card;

update credit_card
SET Week_Start_Date = STR_TO_DATE(Week_Start_Date, '%d-%m-%Y');

ALTER TABLE credit_card
MODIFY COLUMN Week_Start_Date DATE;

describe credit_card;

ALTER TABLE credit_card
CHANGE COLUMN `Use Chip` `use_chip` text;

ALTER TABLE credit_card
CHANGE COLUMN  `Exp Type` `exp_type` text;  -- use brackets insted of this

ALTER TABLE credit_card
CHANGE COLUMN ï»¿Client_Num client_No text;

describe credit_card;

-- 1. Total Spending per Card i.e Chip  and Swipe :

select use_chip, sum(Total_Trans_Amt) as Total_card_transaction  
	   from credit_card
       where use_chip = 'Chip ' or use_chip ='Swipe '
       group by use_chip;

-- 2. Monthly Spending Trend for a Card
select monthname(Week_Start_Date) as Month, 
			sum(Total_Trans_Amt) as Total_monthly_spending 
			from credit_card
			group by month(Week_Start_Date),monthname(Week_Start_Date)
		    order by month(Week_Start_Date);

-- 3. Highest Transaction Amount per Card

select Total_Trans_Amt as Highest_transaction_amount from credit_card
order by Total_Trans_Amt desc limit Total_Trans_Amt;

select Total_Trans_Amt as Highest_transaction_amount from credit_card
order by 1 desc limit 5;

-- 4. Top expenses Based on Spending
select exp_type, Total_Trans_Amt from credit_card
order by Total_Trans_Amt desc limit 5;

-- 5. Average Transaction Amount per Card
select avg(Total_Trans_Amt) as Avg_transaction_amt from credit_card;

-- 6. Find Cards with the highest int rate and annual fee

select client_No,Annual_Fees, Interest_Earned from credit_card
order by Annual_Fees, Interest_Earned desc limit 10;

-- 7. User's Total Spending in each category

select exp_type as Exp_Category, sum(Total_Trans_Amt) as Total_amt_spend 
	   from credit_card 
       group by Exp_Category order by Total_amt_spend  desc;


/*  8. Users Who Spent Over a Certain Amount
This query finds users who spent more than a certain amount within a time period (e.g., $5,000 between 2024-01-01 and 2024-12-31): */

select Week_Start_Date,exp_type, Total_Trans_Amt  from credit_card
where Total_Trans_Amt > 5000
and Week_Start_Date between '2023-10-10' and '2023-12-24' ;

-- 9. Days with Highest Spending

SELECT day(Week_Start_Date) as Days_with_Max_Spendings, SUM(Total_Trans_Amt) AS Total_spent
FROM credit_card
GROUP BY day(Week_Start_Date)
ORDER BY Total_spent DESC
LIMIT 10;




SELECT day(Week_Start_Date), SUM(Total_Trans_Amt) AS total_spent
FROM credit_card
WHERE exp_type = 'Grocery'
GROUP BY day(Week_Start_Date)
ORDER BY day(Week_Start_Date) DESC
LIMIT 10;

-- 10. Active Cards with No Transactions in Last 30 Days

SELECT client_No
FROM credit_card
    WHERE Week_Start_Date >= CURRENT_DATE() - INTERVAL 30 day
ORDER BY client_No;

select * from credit_card;
-- extra queries
--  Find the Cardholder with the Highest Credit Limit

select client_No, Credit_Limit from credit_card
order by Credit_Limit desc limit 1;

-- 9. Update the Balance of a Credit Card
select * from credit_card;


update credit_card
set credit_limit =2000
where client_No = 708082083;
