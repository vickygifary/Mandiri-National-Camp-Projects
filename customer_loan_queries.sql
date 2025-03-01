-- Calculate Age of Customers and Count per Age Group
SELECT TIMESTAMPDIFF(YEAR, DATE_OF_BIRTH, CURDATE()) AS Age, 
       COUNT(*) AS Customer_Count 
FROM Customers 
GROUP BY Age 
ORDER BY Age;

-- Calculate Average Age and Count of Customers per Employment Type
SELECT EMPLOYMENT_TYPE, 
       AVG(TIMESTAMPDIFF(YEAR, DATE_OF_BIRTH, CURDATE())) AS Average_Age, 
       COUNT(*) AS Customer_Count 
FROM Customers 
GROUP BY EMPLOYMENT_TYPE 
ORDER BY Average_Age DESC;

-- Count Missing Values in Key Customer Attributes
SELECT SUM(CASE WHEN DATE_OF_BIRTH IS NULL THEN 1 ELSE 0 END) AS Missing_DOB, 
       SUM(CASE WHEN EMPLOYMENT_TYPE IS NULL THEN 1 ELSE 0 END) AS Missing_Employment_Type, 
       SUM(CASE WHEN CURRENT_PINCODE_ID IS NULL THEN 1 ELSE 0 END) AS Missing_Pincode 
FROM Customers;

-- Count Customers per Pincode
SELECT CURRENT_PINCODE_ID, COUNT(*) AS Customer_Count 
FROM Customers 
GROUP BY CURRENT_PINCODE_ID 
ORDER BY Customer_Count DESC;

-- Average Age of Customers per Pincode and Employment Type
SELECT CURRENT_PINCODE_ID, EMPLOYMENT_TYPE, 
       AVG(TIMESTAMPDIFF(YEAR, DATE_OF_BIRTH, CURDATE())) AS Average_Age 
FROM Customers 
GROUP BY CURRENT_PINCODE_ID, EMPLOYMENT_TYPE 
ORDER BY CURRENT_PINCODE_ID, Average_Age DESC;

-- Calculate Loan Default Rate
SELECT (SUM(CASE WHEN LOAN_DEFAULT = TRUE THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS Default_Rate 
FROM Loans;

-- Count Loans per LTV (Loan-to-Value Ratio)
SELECT LTV, COUNT(*) AS Loan_Count 
FROM Loans 
GROUP BY LTV 
ORDER BY LTV DESC;

-- Average Loan Amount and Loan Count per Asset Cost
SELECT ASSET_COST, 
       AVG(DISBURSED_AMOUNT) AS Average_Loan_Amount, 
       COUNT(*) AS Loan_Count 
FROM Loans 
GROUP BY ASSET_COST 
ORDER BY ASSET_COST DESC;

-- Loan Count and Total Loan Amount per State (Top 10 States by Loan Amount)
SELECT C.STATE_ID, 
       COUNT(L.LOAN_ID) AS Loan_Count, 
       SUM(L.DISBURSED_AMOUNT) AS Total_Loan_Amount 
FROM Loans L 
JOIN Customers C ON L.CUSTOMER_ID = C.UNIQUEID 
GROUP BY C.STATE_ID 
ORDER BY Total_Loan_Amount DESC 
LIMIT 10;

-- Count Delays in Financial History per Score Description
SELECT PERFORM_CNS_SCORE_DESCRIPTION, COUNT(*) AS Delay_Count 
FROM Financial_History 
GROUP BY PERFORM_CNS_SCORE_DESCRIPTION 
ORDER BY Delay_Count DESC;

-- Average Credit Score per Number of Inquiries
SELECT NO_OF_INQUIRIES, 
       AVG(PERFORM_CNS_SCORE) AS Avg_Credit_Score, 
       COUNT(*) AS Inquiry_Count 
FROM Financial_History 
GROUP BY NO_OF_INQUIRIES 
ORDER BY NO_OF_INQUIRIES DESC;

-- Alternative Query: Average Credit Score per Number of Inquiries (Duplicate Query Optimized)
SELECT NO_OF_INQUIRIES, 
       AVG(PERFORM_CNS_SCORE) AS Average_Credit_Score 
FROM Financial_History 
GROUP BY NO_OF_INQUIRIES 
ORDER BY NO_OF_INQUIRIES DESC;

-- Average Credit Score per Account Age Group
SELECT AVERAGE_ACCT_AGE, 
       AVG(PERFORM_CNS_SCORE) AS Avg_Credit_Score, 
       COUNT(*) AS Account_Count 
FROM Financial_History 
GROUP BY AVERAGE_ACCT_AGE 
ORDER BY AVERAGE_ACCT_AGE DESC;
