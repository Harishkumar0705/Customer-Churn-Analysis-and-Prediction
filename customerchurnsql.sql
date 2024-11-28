create database cc;
use cc;
select * from customer_churn1;

#1Find the average age of churned customers

SELECT AVG(Age) AS Average_Age_of_Churned_Customers
FROM customer_churn1
WHERE CustomerStatus = 'Churned';

#I2dentify the total number of customers and the churn rate
SELECT COUNT(`Customer ID`) AS Total_Customers,
    SUM(CASE WHEN CustomerStatus = 'Churned' THEN 1 ELSE 0 END) AS Churned_Customers,
    (SUM(CASE WHEN CustomerStatus = 'Churned' THEN 1 ELSE 0 END) * 100.0 / COUNT(`Customer ID`)) AS Churn_Rate_Percentage
FROM customer_churn1;
    
#3Discover the most common contract types among churned customers
SELECT Contract,
    COUNT(*) AS Churned_Customers_Count
FROM customer_churn1
WHERE CustomerStatus = 'Churned'
GROUP BY Contract
ORDER BY Churned_Customers_Count DESC;
#4Analyze the distribution of monthly charges among churned customers
    SELECT 
    MIN(`Monthly Charge`) AS Min_Monthly_Charge,
    MAX(`Monthly Charge`) AS Max_Monthly_Charge,
    AVG(`Monthly Charge`) AS Avg_Monthly_Charge,
    STDDEV(`Monthly Charge`) AS StdDev_Monthly_Charge
FROM customer_churn1
WHERE CustomerStatus = 'Churned';
#5Create a query to identify the contract types that are most prone to chum
SELECT 
    Contract,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN CustomerStatus = 'Churned' THEN 1 ELSE 0 END) AS Churned_Customers,
    (SUM(CASE WHEN CustomerStatus = 'Churned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS Churn_Rate_Percentage
FROM customer_churn1
GROUP BY Contract
ORDER BY Churn_Rate_Percentage DESC;
#6Identify customers with high total charges who have churned
SELECT `Customer ID`,`Total Charges`,`CustomerStatus`
FROM customer_churn1
WHERE CustomerStatus = 'Churned'
ORDER BY `Total Charges` DESC;
#7Calculate the total charges distribution for churned and non-churned customers
SELECT CustomerStatus,
    MIN(`Total Charges`) AS Min_Total_Charges,
    MAX(`Total Charges`) AS Max_Total_Charges,
    AVG(`Total Charges`) AS Avg_Total_Charges,
    STDDEV(`Total Charges`) AS StdDev_Total_Charges
FROM customer_churn1
GROUP BY CustomerStatus;
#8Calculate the average monthly charges for different contract types among churned customers
SELECT Contract,
    AVG(`Monthly Charge`) AS Avg_Monthly_Charge
FROM customer_churn1
WHERE CustomerStatus = 'Churned'
GROUP BY Contract;
#9Identify customers who have both online security and online backup services and have not churned
SELECT `Customer ID`,`Online Security`,`Online Backup`,`CustomerStatus`
FROM customer_churn1
WHERE 
    `Online Security` = 'yes'
    AND `Online Backup` = 'yes'
    AND `CustomerStatus` != 'Churned';
#10Determine the most common combinations of services among churned customers
SELECT `Phone Service`,`Internet Service`,
    COUNT(*) AS Combination_Count
FROM customer_churn1
WHERE CustomerStatus = 'Churned'
GROUP BY `Phone Service`, `Internet Service`
ORDER BY Combination_Count DESC;
#11Identify the average total charges for customers grouped by gender and marital status
SELECT Gender,Married,
    AVG(`Total Charges`) AS Avg_Total_Charges
FROM customer_churn1
GROUP BY Gender, Married
ORDER BY Gender, Married;
#12Calculate the average monthly charges for different age groups among churned customers
SELECT 
    CASE 
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60 and above'
    END AS Age_Group,
    AVG(`Monthly Charge`) AS Avg_Monthly_Charge
FROM customer_churn1
WHERE CustomerStatus = 'Churned'
GROUP BY Age_Group
ORDER BY Age_Group;
#13Determine the average age and total charges for customers with multiple lines and online backup
SELECT AVG(Age) AS Avg_Age,
    SUM(`Total Charges`) AS Total_Charges
FROM customer_churn1
WHERE `Multiple Lines` = 'yes' 
AND `Online Backup` = 'yes';
#14Identify the contract types with the highest churn rate among senior citizens (age65 and over)
SELECT Contract,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN CustomerStatus = 'Churned' THEN 1 ELSE 0 END) AS Churned_Customers,
    (SUM(CASE WHEN CustomerStatus = 'Churned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS Churn_Rate_Percentage
FROM customer_churn1
WHERE Age >= 65
GROUP BY Contract
ORDER BY Churn_Rate_Percentage DESC;
#15Calculate the average monthly charges for customers who have multiple lines and streaming TV
SELECT AVG(`Monthly Charge`) AS Avg_Monthly_Charges
FROM customer_churn1
WHERE `Multiple Lines` = 'yes' 
AND `Streaming TV` = 'yes';
#16Identify the customers who have churned and used the most online services
SELECT `Customer ID`,`Gender`,`Age`,`Married`,`Total Charges`,
(`Online Security` = 'yes') AS Online_Service_Count
from customer_churn1
WHERE `CustomerStatus` = 'Churned'
ORDER BY Online_Service_Count DESC;
#17Calculate the average age and total charges for customers with different combinations of streaming services
SELECT `Streaming TV`,`Streaming Movies`,`Streaming Music`,
    AVG(Age) AS Avg_Age,
    SUM('TotalCharges') AS Total_Charges
FROM customer_churn1
GROUP BY `Streaming TV`,`Streaming Movies`,`Streaming Music`
ORDER BY `Streaming TV`, `Streaming Movies`, `Streaming Music`;
#18Identify the gender distribution among customers who have churned and are on yearly contracts
SELECT Gender,
    COUNT(*) AS Churned_Customers_Count
FROM customer_churn1
WHERE CustomerStatus = 'Churned'
    AND Contract = 'one year'
GROUP BY Gender
ORDER BY Churned_Customers_Count DESC;
#19Calculate the average monthly charges and total charges for customers who have churned, grouped by contract type and internet service type
SELECT Contract,`Internet Service`,  
    AVG('Monthly Charge') AS Avg_Monthly_Charges,
    SUM('Total Charges') AS Total_Charges
FROM customer_churn1
WHERE CustomerStatus = 'Churned'
GROUP BY Contract,`Internet Service`  
ORDER BY Contract, `Internet Service`;  
#20Find the customers who have churned and are not using online services, and their average total charges
SELECT AVG(`Total Charges`) AS Avg_Total_Charges
FROM customer_churn1
WHERE `CustomerStatus` = 'Churned' AND
    (`Online Security` = 'no' OR `Online Security` IS NULL) AND
    (`Online Backup` = 'no' OR `Online Backup` IS NULL) AND
    (`Device Protection Plan` = 'no' OR `Device Protection Plan` IS NULL) AND
    (`Premium Tech Support` = 'no' OR `Premium Tech Support` IS NULL);
#21Calculate the average monthly charges and total charges for customers who have churned, grouped by the number of dependents
SELECT `Number of Dependents`, 
    AVG(`Monthly Charge`) AS Avg_Monthly_Charges, 
    SUM(`Total Charges`) AS Total_Charges 
FROM customer_churn1 
WHERE `CustomerStatus` = 'Churned' 
GROUP BY `Number of Dependents` 
ORDER BY `Number of Dependents`;
#22Identify the customers who have churned, and their contract duration in months (for monthly contracts)
SELECT `Customer ID`, `Gender`, `Age`, `Married`, `Tenure in Months`, `Contract` 
FROM customer_churn1 
WHERE `CustomerStatus` = 'Churned' 
AND `Contract` = 'Month-to-Month';
#23Determine the average age and total charges for customers who have churned, grouped by internet service and phone service
SELECT `Internet Service`, `Phone Service`, 
    AVG('Age') AS Avg_Age, 
    SUM('TotalCharges') AS Total_Charges 
FROM customer_churn1 
WHERE `CustomerStatus` = 'Churned' 
GROUP BY `Internet Service`, `Phone Service` 
ORDER BY `Internet Service`, `Phone Service`;
#24Create a view to find the customers with the highest monthly charges in each contract type
CREATE VIEW HighestMonthlyChargesByContract AS
SELECT 
    c.*
FROM 
    customer_churn1 c
JOIN (
    SELECT 
        `Contract`, 
        MAX(`Monthly Charge`) AS MaxMonthlyCharge
    FROM 
        customer_churn1
    GROUP BY 
        `Contract`
) AS max_charges ON c.`Contract` = max_charges.`Contract` 
                 AND c.`Monthly Charge` = max_charges.MaxMonthlyCharge;
select * from HighestMonthlyChargesByContract;
#25Create a view to find the customers who have churned and their cumulative total charges over time INNER JOIN
CREATE VIEW ChurnedCustomersCumulativeCharges AS
SELECT c.`Customer ID`,c.`Gender`,c.`Age`,c.`Married`,c.`Tenure in Months`,
    SUM(c.`Total Charges`) OVER (PARTITION BY c.`Customer ID` ORDER BY c.`Tenure in Months`) AS Cumulative_Total_Charges
FROM customer_churn1 c
WHERE c.`CustomerStatus` = 'Churned';
SELECT * FROM ChurnedCustomersCumulativeCharges;
#26Stored Procedure to Calculate Churn Rate
DELIMITER //

CREATE PROCEDURE CalculateChurnRate(IN startDate DATE, IN endDate DATE, OUT churnRate DECIMAL(5,2))
BEGIN
    DECLARE totalCustomers INT;
    DECLARE churnedCustomers INT;

    -- Calculate total customers at the start of the period
    SELECT COUNT(*)
    INTO totalCustomers
    FROM customer_churn1
    WHERE CustomerStatus IN ('Joined', 'Stayed') AND 
          DATE(TIMESTAMPADD(MONTH, -1, CreatedDate)) <= startDate; -- Assuming there is a CreatedDate for customers

    -- Calculate churned customers during the specified period
    SELECT COUNT(*)
    INTO churnedCustomers
    FROM customer_churn1
    WHERE CustomerStatus = 'Churned' AND 
          CreatedDate BETWEEN startDate AND endDate; -- Assuming CreatedDate reflects the churn date

    -- Calculate churn rate
    IF totalCustomers > 0 THEN
        SET churnRate = (churnedCustomers / totalCustomers) * 100;
    ELSE
        SET churnRate = 0; -- Avoid division by zero
    END IF;

END$$

DELIMITER ;
CALL CalculateChurnRate('2024-01-01', '2024-01-31', @churnRate);
SELECT @churnRate AS 'Churn Rate';
#27Stored Procedure to Identify High-Value Customers at Risk of Churning.
DELIMITER //

CREATE PROCEDURE IdentifyHighValueChurnRiskCustomers(
    IN minTotalCharges DECIMAL(10,2), 
    IN minTenureMonths INT, 
    OUT highValueChurnRiskCount INT
)
BEGIN
    -- Temporary table to hold high-value customers at risk of churning
    CREATE TEMPORARY TABLE IF NOT EXISTS HighValueChurnRiskCustomers AS 
    SELECT 
        CustomerID,
        Gender,
        Age,
        Married,
        TotalCharges,
        `Tenure in Months`,
        `Monthly Charge`,
        `Contract`,
        `CustomerStatus`
    FROM 
        customer_churn1
    WHERE 
        TotalCharges > minTotalCharges 
        AND `Tenure in Months` > minTenureMonths 
        AND CustomerStatus = 'Churned'
        AND (
            (`Online Security` = 'no' OR `Online Security` IS NULL)
            AND (`Online Backup` = 'no' OR `Online Backup` IS NULL)
            AND (`Device Protection Plan` = 'no' OR `Device Protection Plan` IS NULL)
            AND (`Premium Tech Support` = 'no' OR `Premium Tech Support` IS NULL)
        );

    -- Get the count of high-value customers at risk
    SELECT COUNT(*) INTO highValueChurnRiskCount FROM HighValueChurnRiskCustomers;

    -- Optionally, select the customers
    SELECT * FROM HighValueChurnRiskCustomers;

    -- Cleanup
    DROP TEMPORARY TABLE IF EXISTS HighValueChurnRiskCustomers;
END //

DELIMITER ;
CALL IdentifyHighValueChurnRiskCustomers(5000.00, 12, @highValueChurnRiskCount);
SELECT @highValueChurnRiskCount AS 'High Value Churn Risk Customer Count';
#28create a view to identify customers who have churned an the average monthly charges compared to overall average
CREATE VIEW ChurnedCustomersAverageMonthlyCharges AS
SELECT c.`Customer ID`,c.Gender,c.Age,c.Married,churnedcustomersaveragemonthlychargeschurnedcustomersaveragemonthlychargesc.`Total Charges`,
    AVG(c.`Monthly Charge`) AS Avg_Monthly_Charges,
    (SELECT AVG(`Monthly Charge`) FROM customer_churn1) AS Overall_Avg_Monthly_Charges
FROM 
    customer_churn1 c
WHERE 
    c.CustomerStatus = 'Churned'
GROUP BY 
    c.`Customer ID`, c.Gender, c.Age, c.Married, c.`Total Charges`;
SELECT * FROM ChurnedCustomersAverageMonthlyCharges;
