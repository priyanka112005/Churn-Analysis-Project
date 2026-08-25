create database db_churn;

select *
from customer_churn;

-----------------------------------------------------
## Data Exploration – Check Distinct Values

SELECT gender,
COUNT(gender) as TotalCount,
100 * COUNT(gender) / (SELECT COUNT(*) FROM customer_churn) AS Percentage 
FROM customer_churn
GROUP BY gender;


SELECT Contract, Count(Contract) as TotalCount,
100*Count(Contract) / (Select Count(*) from customer_churn)  as Percentage
from customer_churn
Group by Contract;


SELECT Customer_Status, Count(Customer_Status) as TotalCount, round(Sum(Total_Revenue),2) as TotalRev,
round(100*Sum(Total_Revenue) / (Select sum(Total_Revenue) from customer_Churn),2) as RevPercentage
from customer_churn
Group by Customer_Status;


SELECT State, Count(State) as TotalCount,
100*Count(State)/ (Select Count(*) from customer_churn)  as Percentage
from customer_churn
Group by State
Order by Percentage desc;



---------------------------------------------------------------------
## Data Quality check table

#1. Duplicate Customer IDs
SELECT Customer_ID, COUNT(*) AS Count
FROM customer_churn
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

#2. Negative Total Charges
SELECT *
FROM customer_churn
WHERE Total_Charges < 0;

#3. Negative Revenue / Refunds
SELECT *
FROM customer_churn
WHERE Total_Revenue < 0
   OR Total_Refunds < 0
   OR Total_Extra_Data_Charges < 0
   OR Total_Long_Distance_Charges < 0;
   
#4. Invalid Age
SELECT *
FROM customer_churn
WHERE Age < 0 OR Age > 100;

#5. Invalid Tenure
SELECT *
FROM customer_churn
WHERE Tenure_in_Months < 0;

#6. Logical Revenue Check
SELECT *
FROM customer_churn
WHERE Total_Revenue < Total_Charges;


---------------------------------------------------------------
##Data Exploration – Check Nulls
SELECT 
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Customer_ID_Null_Count,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_Null_Count,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_Null_Count,
    SUM(CASE WHEN Married IS NULL THEN 1 ELSE 0 END) AS Married_Null_Count,
    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS State_Null_Count,
    SUM(CASE WHEN Number_of_Referrals IS NULL THEN 1 ELSE 0 END) AS Number_of_Referrals_Null_Count,
    SUM(CASE WHEN Tenure_in_Months IS NULL THEN 1 ELSE 0 END) AS Tenure_in_Months_Null_Count,
    SUM(CASE WHEN Value_Deal IS NULL THEN 1 ELSE 0 END) AS Value_Deal_Null_Count,
    SUM(CASE WHEN Phone_Service IS NULL THEN 1 ELSE 0 END) AS Phone_Service_Null_Count,
    SUM(CASE WHEN Multiple_Lines IS NULL THEN 1 ELSE 0 END) AS Multiple_Lines_Null_Count,
    SUM(CASE WHEN Internet_Service IS NULL THEN 1 ELSE 0 END) AS Internet_Service_Null_Count,
    SUM(CASE WHEN Internet_Type IS NULL THEN 1 ELSE 0 END) AS Internet_Type_Null_Count,
    SUM(CASE WHEN Online_Security IS NULL THEN 1 ELSE 0 END) AS Online_Security_Null_Count,
    SUM(CASE WHEN Online_Backup IS NULL THEN 1 ELSE 0 END) AS Online_Backup_Null_Count,
    SUM(CASE WHEN Device_Protection_Plan IS NULL THEN 1 ELSE 0 END) AS Device_Protection_Plan_Null_Count,
    SUM(CASE WHEN Premium_Support IS NULL THEN 1 ELSE 0 END) AS Premium_Support_Null_Count,
    SUM(CASE WHEN Streaming_TV IS NULL THEN 1 ELSE 0 END) AS Streaming_TV_Null_Count,
    SUM(CASE WHEN Streaming_Movies IS NULL THEN 1 ELSE 0 END) AS Streaming_Movies_Null_Count,
    SUM(CASE WHEN Streaming_Music IS NULL THEN 1 ELSE 0 END) AS Streaming_Music_Null_Count,
    SUM(CASE WHEN Unlimited_Data IS NULL THEN 1 ELSE 0 END) AS Unlimited_Data_Null_Count,
    SUM(CASE WHEN Contract IS NULL THEN 1 ELSE 0 END) AS Contract_Null_Count,
    SUM(CASE WHEN Paperless_Billing IS NULL THEN 1 ELSE 0 END) AS Paperless_Billing_Null_Count,
    SUM(CASE WHEN Payment_Method IS NULL THEN 1 ELSE 0 END) AS Payment_Method_Null_Count,
    SUM(CASE WHEN Monthly_Charge IS NULL THEN 1 ELSE 0 END) AS Monthly_Charge_Null_Count,
    SUM(CASE WHEN Total_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Charges_Null_Count,
    SUM(CASE WHEN Total_Refunds IS NULL THEN 1 ELSE 0 END) AS Total_Refunds_Null_Count,
    SUM(CASE WHEN Total_Extra_Data_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Extra_Data_Charges_Null_Count,
    SUM(CASE WHEN Total_Long_Distance_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Long_Distance_Charges_Null_Count,
    SUM(CASE WHEN Total_Revenue IS NULL THEN 1 ELSE 0 END) AS Total_Revenue_Null_Count,
    SUM(CASE WHEN Customer_Status IS NULL THEN 1 ELSE 0 END) AS Customer_Status_Null_Count,
    SUM(CASE WHEN Churn_Category IS NULL THEN 1 ELSE 0 END) AS Churn_Category_Null_Count,
    SUM(CASE WHEN Churn_Reason IS NULL THEN 1 ELSE 0 END) AS Churn_Reason_Null_Count
FROM customer_churn;


-----------------------------------------------------------------
##Remove null and insert the new data into Prod table
CREATE TABLE db_Churn.prod_Churn AS
SELECT 
    Customer_ID,
    Gender,
    Age,
    Married,
    State,
    Number_of_Referrals,
    Tenure_in_Months,
    IFNULL(Value_Deal, 'None') AS Value_Deal,
    Phone_Service,
    IFNULL(Multiple_Lines, 'No') AS Multiple_Lines,
    Internet_Service,
    IFNULL(Internet_Type, 'None') AS Internet_Type,
    IFNULL(Online_Security, 'No') AS Online_Security,
    IFNULL(Online_Backup, 'No') AS Online_Backup,
    IFNULL(Device_Protection_Plan, 'No') AS Device_Protection_Plan,
    IFNULL(Premium_Support, 'No') AS Premium_Support,
    IFNULL(Streaming_TV, 'No') AS Streaming_TV,
    IFNULL(Streaming_Movies, 'No') AS Streaming_Movies,
    IFNULL(Streaming_Music, 'No') AS Streaming_Music,
    IFNULL(Unlimited_Data, 'No') AS Unlimited_Data,
    Contract,
    Paperless_Billing,
    Payment_Method,
    Monthly_Charge,
    Total_Charges,
    Total_Refunds,
    Total_Extra_Data_Charges,
    Total_Long_Distance_Charges,
    Total_Revenue,
    Customer_Status,
    IFNULL(Churn_Category, 'Others') AS Churn_Category,
    IFNULL(Churn_Reason, 'Others') AS Churn_Reason
FROM db_Churn.customer_churn;

select * from prod_churn;


----------------------------------------------------------------
## Customer & Churn Analysis.

#1. Overall Churn Rate
SELECT
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        100.0 * SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END) / COUNT(*), 2
    ) AS Churn_Rate
FROM prod_Churn
WHERE Customer_Status IN ('Churned', 'Stayed');


#2. Churn by Contract
SELECT
    Contract,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        100.0 * SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END) / COUNT(*), 2
    ) AS Churn_Rate
FROM prod_Churn
WHERE Customer_Status IN ('Churned', 'Stayed')
GROUP BY Contract
ORDER BY Churn_Rate DESC;


#3. Churn by Tenure Group
SELECT
    CASE
        WHEN Tenure_in_Months < 6 THEN '< 6 Months'
        WHEN Tenure_in_Months < 12 THEN '6-11 Months'
        WHEN Tenure_in_Months < 18 THEN '12-17 Months'
        WHEN Tenure_in_Months < 24 THEN '18-23 Months'
        ELSE '24+ Months'
    END AS Tenure_Group,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        100.0 * SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END) / COUNT(*), 2
    ) AS Churn_Rate
FROM prod_Churn
WHERE Customer_Status IN ('Churned', 'Stayed')
GROUP BY Tenure_Group
ORDER BY Churn_Rate DESC;


#4. Churn by Age Group
SELECT
    CASE
        WHEN Age < 20 THEN '< 20'
        WHEN Age < 36 THEN '20-35'
        WHEN Age < 51 THEN '36-50'
        ELSE '50+'
    END AS Age_Group,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        100.0 * SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END) / COUNT(*), 2
    ) AS Churn_Rate
FROM prod_Churn
WHERE Customer_Status IN ('Churned', 'Stayed')
GROUP BY Age_Group
ORDER BY Churn_Rate DESC;


#5. Churn by Payment Method
SELECT
    Payment_Method,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        100.0 * SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END) / COUNT(*), 2
    ) AS Churn_Rate
FROM prod_Churn
WHERE Customer_Status IN ('Churned', 'Stayed')
GROUP BY Payment_Method
ORDER BY Churn_Rate DESC;


#6. Churn by State
SELECT
    State,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        100.0 * SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END) / COUNT(*), 2
    ) AS Churn_Rate
FROM prod_Churn
WHERE Customer_Status IN ('Churned', 'Stayed')
GROUP BY State
ORDER BY Churn_Rate DESC;


-----------------------------------------------------------------
##Revenue Analysis.

#1. Revenue: Churned vs Stayed
SELECT
    Customer_Status,
    COUNT(*) AS Customers,
    ROUND(SUM(Total_Revenue), 2) AS Total_Revenue,
    ROUND(AVG(Total_Revenue), 2) AS Avg_Revenue_Per_Customer
FROM prod_Churn
WHERE Customer_Status IN ('Churned', 'Stayed')
GROUP BY Customer_Status;


#2. Monthly Charge: Churned vs Stayed
SELECT
    Customer_Status,
    ROUND(AVG(Monthly_Charge), 2) AS Avg_Monthly_Charge
FROM prod_Churn
WHERE Customer_Status IN ('Churned', 'Stayed')
GROUP BY Customer_Status;


#3. Revenue by Contract
SELECT
    Contract,
    COUNT(*) AS Customers,
    ROUND(SUM(Total_Revenue), 2) AS Total_Revenue,
    ROUND(AVG(Total_Revenue), 2) AS Avg_Revenue
FROM prod_Churn
WHERE Customer_Status IN ('Churned', 'Stayed')
GROUP BY Contract
ORDER BY Total_Revenue DESC;


#4. Revenue Lost from Churned Customers
SELECT
    COUNT(*) AS Churned_Customers,
    ROUND(SUM(Total_Revenue), 2) AS Revenue_From_Churned_Customers,
    ROUND(AVG(Total_Revenue), 2) AS Avg_Revenue_Per_Churned_Customer
FROM prod_Churn
WHERE Customer_Status = 'Churned';


#5. High-Value Churned Customers
SELECT
    Customer_ID,
    Total_Revenue,
    Monthly_Charge,
    Tenure_in_Months,
    Contract
FROM prod_Churn
WHERE Customer_Status = 'Churned'
ORDER BY Total_Revenue DESC
LIMIT 20;


--------------------------------------------------------------
##Advanced Business Analysis. Keep it to 3 strong queries.

#1. Rank States by Churn Rate
SELECT
    State,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        100.0 * SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END) / COUNT(*), 2
    ) AS Churn_Rate,
    RANK() OVER (
        ORDER BY
        100.0 * SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END) / COUNT(*) DESC
    ) AS Churn_Rank
FROM prod_Churn
WHERE Customer_Status IN ('Churned', 'Stayed')
GROUP BY State;


#2. High-Value Customers Who Churned
WITH Avg_Revenue AS (
    SELECT AVG(Total_Revenue) AS Avg_Revenue
    FROM prod_Churn
    WHERE Customer_Status IN ('Churned', 'Stayed')
)
SELECT
    Customer_ID,
    Total_Revenue,
    Monthly_Charge,
    Tenure_in_Months,
    Contract
FROM prod_Churn
WHERE Customer_Status = 'Churned'
  AND Total_Revenue > (SELECT Avg_Revenue FROM Avg_Revenue)
ORDER BY Total_Revenue DESC;


#3. Churn Rate by Monthly Charge Segment
SELECT
    CASE
        WHEN Monthly_Charge < 20 THEN '< 20'
        WHEN Monthly_Charge < 50 THEN '20-50'
        WHEN Monthly_Charge < 100 THEN '50-100'
        ELSE '100+'
    END AS Charge_Group,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        100.0 * SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END) / COUNT(*), 2
    ) AS Churn_Rate
FROM prod_Churn
WHERE Customer_Status IN ('Churned', 'Stayed')
GROUP BY Charge_Group
ORDER BY Churn_Rate DESC;


-----------------------------------------------------
#Create View for Power BI
Create View vw_ChurnData as
	select * from prod_Churn where Customer_Status In ('Churned', 'Stayed');


Create View vw_JoinData as
	select * from prod_Churn where Customer_Status = 'Joined';





