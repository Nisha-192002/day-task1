CREATE TABLE telecom_data (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(50),
    Age INT,
    Gender VARCHAR(10),
    Plan_Type VARCHAR(10),
    Data_Usage INT,
    Call_Usage INT,
    SMS_Sent INT,
    Monthly_Payment INT,
    Plan_Duration INT,
    Churn_Status VARCHAR(5),
    Last_Recharge DATE,
    Customer_City VARCHAR(50)
);

INSERT INTO telecom_data VALUES
(2001, 'Customer', 56, 'Female', 'Prepaid', 25, 350, 109, 98, 13, 'Yes', '2024-02-06', 'Seattle'),
(2002, 'Customer', 68, 'Male', 'Postpaid', 54, 548, 175, 113, 21, 'No', '2024-02-06', 'Houston'),
(2003, 'Customer', 64, 'Male', 'Postpaid', 74, 381, 44, 102, 28, 'No', '2024-02-06', 'Dallas');

-- Get all customers who churned
SELECT * FROM telecom_data
WHERE Churn_Status = 'Yes'
ORDER BY Plan_Duration DESC;

-- Average Monthly Payment per city
SELECT Customer_City, AVG(Monthly_Payment) AS Avg_Payment
FROM telecom_data
GROUP BY Customer_City;

CREATE TABLE city_info (
    City_Name VARCHAR(50),
    Region VARCHAR(50)
);

-- Sample JOIN
SELECT td.Customer_ID, td.Customer_City, ci.Region
FROM telecom_data td
JOIN city_info ci ON td.Customer_City = ci.City_Name;

-- Get customers with above average data usage
SELECT * FROM telecom_data
WHERE Data_Usage > (SELECT AVG(Data_Usage) FROM telecom_data);

-- Total usage (data + call) by gender
SELECT Gender, SUM(Data_Usage + Call_Usage) AS Total_Usage
FROM telecom_data
GROUP BY Gender;

CREATE VIEW active_customers AS
SELECT Customer_ID, Age, Plan_Type, Monthly_Payment
FROM telecom_data
WHERE Churn_Status = 'No';

-- Add index for faster WHERE filter on churn
CREATE INDEX idx_churn_status ON telecom_data (Churn_Status);
