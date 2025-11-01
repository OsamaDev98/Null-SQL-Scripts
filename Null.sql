USE SalesDB;

-- Find the average scores of the customers.
SELECT
	CustomerID,
	Score,
	AVG(Score) OVER() AvgScores,
	COALESCE(Score, 0) AS Score2,
	AVG(COALESCE(Score, 0)) OVER() AvgScores2
FROM
	Sales.Customers;

/*
	Display the full name of customers in a single field
	By merging thier first and last names,
	And add 10 bonus points to each customer`s score.
*/
SELECT
	CustomerID,
	FirstName,
	LastName,
	COALESCE(FirstName, '') + ' ' + COALESCE(LastName, '') AS FullName,
	Score,
	COALESCE(Score, 0) + 10 AS ScoreWithBouns
FROM
	Sales.Customers;

/*
	Sort the customers from lowest to highest scores,
	With nulls appearing last. (Using Flag) 
*/
SELECT
	CustomerID,
	Score
FROM
	Sales.Customers
ORDER BY
	CASE WHEN Score IS NULL THEN 1 ELSE 0 END, Score ASC;

-- Find the sales price for each order by dividing sales by quantity.
SELECT
	OrderID,
	Sales,
	Quantity,
	Sales/NULLIF(Quantity, 0) AS Final
FROM
	Sales.Orders;

-- Identify the customers who have no scores.
SELECT
	*
FROM
	Sales.Customers
WHERE
	Score IS NULL;

-- Show all customers who have scores.
SELECT
	*
FROM
	Sales.Customers
WHERE
	Score IS NOT NULL;

-- List all details for customers who have not placed any orders.
SELECT
	C.*,
	O.OrderID
FROM
	Sales.Customers C
LEFT JOIN
	Sales.Orders O
ON
	C.CustomerID = O.CustomerID
WHERE
	O.CustomerID IS NULL;



