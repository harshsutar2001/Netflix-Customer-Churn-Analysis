Create Database Netflix_Project;

use Netflix_Project;

select*
from Netflix;

-- Total Customer-- 

select count(*) as Total_Customer
from Netflix;

-- 1] Total_Churned_Customer

select count(*) as Total_Churned_Customer
from Netflix
where Churn=1;

-- Insight: 14258 customers have discontinued their subscription, indicating potential retention challenges.

-- 2] Churn Rate % 

select 
round(
count(case when churn='1' then 1 end)*100.0/count(*),2) 
as chrun_rate 
from Netflix;

--Insight: The overall churn rate is 57.030%, showing the percentage of customers who left the platform.
 
--3] subcription plan wise Churn

select subscription_plan,count(*) as Total_Customes,
sum(case when churn ='1' then 1 else 0 end)as churned_customer
from Netflix
group by Subscription_Plan;

--Insight: The Premium plan recorded the highest number of churned customers, suggesting plan-specific retention issues.

--4] Age Category wise Churn 

SELECT
Age_Category,
COUNT(*) AS Total_Customers,
SUM(CASE WHEN Churn='1' THEN 1 ELSE 0 END) AS Churned_Customers
FROM netflix
GROUP BY Age_Category;

--Insight: Customers in the Adult Aged category experienced the highest churn, indicating stronger disengagement within this age group.

-- 5] Country wise Churn 

SELECT
Country,
COUNT(*) AS Churned_Customers
FROM netflix
WHERE Churn='1'
GROUP BY Country
ORDER BY Churned_Customers DESC;

--Insight: Customers from Australia contributed the highest number of churns, highlighting a potential regional retention concern.

-- 6] Revenue Lost due to Chrun 

select sum(Monthly_Charges) as Revenue_Lost 
from Netflix 
where Churn='1';

--Insight: Customer churn resulted in an estimated revenue loss of 6186092

-- 7] Satisfaction Score Analysis

SELECT
Satisfaction_Score,
COUNT(*) AS Customers,
SUM(CASE WHEN Churn='1' THEN 1 ELSE 0 END) AS Churned_Customers
FROM netflix
GROUP BY Satisfaction_Score
ORDER BY Satisfaction_Score;

--Insight: Customers with lower satisfaction scores exhibited significantly higher churn levels, indicating a strong relationship between satisfaction and retention.

-- 8] Payment Failure Analysis

SELECT
Payment_Failures,
COUNT(*) AS Customers,
SUM(CASE WHEN Churn='1' THEN 1 ELSE 0 END) AS Churned_Customers
FROM netflix
GROUP BY Payment_Failures
ORDER BY Payment_Failures;

--Insight: Customers with frequent payment failures were more likely to churn, suggesting billing issues as a key churn driver.

--9] Top Risk Customers

SELECT *
FROM netflix
WHERE Churn='1'
AND Satisfaction_Score <=4
AND Payment_Failures >=3;

--Insight: High-risk customers typically have low satisfaction scores and multiple payment failures, making them priority targets for retention campaigns.

-- 10] Top 5 Countries By Revenue 

select top 5 
country,sum(Monthly_Charges) as Revenue 
from Netflix
group by country 
order by country desc;

--Insight: These countries contribute the largest share of subscription revenue and should be prioritized for customer retention efforts.

-- 11] Customer Segmentaion 

select Age_category,subscription_plan,count(*) as Customers
from Netflix
group by Age_category,subscription_plan
order by Customers desc;

--Insight: The largest customer segment consists of "Adult" customers subscribed to the "Standard" plan.

-- 12] Top 10 Customer paying hiegst charge 

select Top 10* 
from Netflix 
order by Monthly_Charges desc;

--Insight: Premium subscribers contribute the highest monthly revenue and represent high-value customers.

-- 13] Device used  vs churn 
SELECT
Devices_Used,
COUNT(*) AS Customers,
SUM(CASE WHEN Churn='1' THEN 1 ELSE 0 END) AS Churned_Customers
FROM netflix
GROUP BY Devices_Used;

--Insight: Churn behavior varies across device usage patterns, indicating that customer engagement may be influenced by platform accessibility.

--KEY BUSINESS ISIGHTS

--1.High Customer Churn is Affecting Revenue
--2.Premium Plan Requires Retention Focus
--3.Adult Customers Represent the Largest Churn Segment
--4.Australia Shows the Highest Customer Attrition
--5.Customer Satisfaction Directly Impacts Retention
--6.Payment Issues Are a Major Churn Driver
--7.High-Risk Customers Can Be Identified Early
--8.Revenue Protection Should Focus on High-Value Customers
--9.Data-Driven Retention Strategies Can Improve Business Performance
