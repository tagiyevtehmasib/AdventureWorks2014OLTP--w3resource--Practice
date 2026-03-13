
--W3Resource All Tasks


--Question 1
SELECT * FROM HumanResources.Employee
ORDER BY JobTitle ASC

-------------------------------------------------------------------------------------

--Question 2
SELECT * FROM Person.Person
ORDER BY LastName

-------------------------------------------------------------------------------------

--Question 3
SELECT FirstName,
LastName,
BusinessEntityID AS Employee_id
FROM Person.Person
ORDER BY LastName ASC

-------------------------------------------------------------------------------------

--Question 4
SELECT ProductID,
ProductNumber,
Name
FROM production.Product 
WHERE SellStartDate IS NOT NULL AND ProductLine = 'T'
ORDER BY Name

-------------------------------------------------------------------------------------

--Question 5
SELECT SalesOrderID,
CustomerID,
OrderDate,
SubTotal,
TaxAmt,
(TaxAmt * 100) / SubTotal AS [Percentage]
FROM Sales.SalesOrderHeader

-------------------------------------------------------------------------------------

--Question 6
SELECT DISTINCT JobTitle
FROM HumanResources.Employee
ORDER BY JobTitle ASC

-------------------------------------------------------------------------------------

--Question 7
SELECT CustomerID,
SUM(Freight)
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY CustomerID

-------------------------------------------------------------------------------------

--Question 8
SELECT CustomerID,
SalesPersonID,
AVG(SubTotal),
SUM(SubTotal)
FROM Sales.SalesOrderHeader
GROUP BY CustomerID, SalesPersonID
ORDER BY CustomerID DESC

-------------------------------------------------------------------------------------

--Question 9
SELECT ProductID AS productid,
SUM(Quantity) AS sum_of_quantity
FROM Production.ProductInventory
WHERE Shelf IN('A', 'C', 'H')
GROUP BY ProductID
HAVING SUM(Quantity) > 500
ORDER BY productid ASC

-------------------------------------------------------------------------------------

--Question 10
SELECT SUM(Quantity)
FROM Production.ProductInventory
GROUP BY (LocationID)

-------------------------------------------------------------------------------------

--Question 11
SELECT pp.BusinessEntityID,
per.LastName,
per.FirstName,
pp.PhoneNumber
FROM Person.PersonPhone pp 
JOIN Person.Person per
ON pp.BusinessEntityID = per.BusinessEntityID
WHERE per.LastName LIKE 'L%'
ORDER BY per.LastName, per.FirstName

-------------------------------------------------------------------------------------

--Question 12
SELECT SalesPersonID,
CustomerID,
SUM(SubTotal)
FROM Sales.SalesOrderHeader
GROUP BY ROLLUP(SalesPersonID, CustomerID)

-------------------------------------------------------------------------------------

--Question 13
SELECT LocationID,
Shelf,
SUM(Quantity) AS TotalQuantity
FROM Production.ProductInventory
GROUP BY grouping sets(LocationID, Shelf)

-------------------------------------------------------------------------------------

--Question 14 . I couldn't understand
SELECT LocationID,
Shelf,
SUM(Quantity) AS TotalQuantity
FROM Production.ProductInventory
GROUP BY GROUPING SETS(ROLLUP(LocationID,Shelf), CUBE(LocationID,Shelf))

-------------------------------------------------------------------------------------

--Question 15
SELECT LocationID,
SUM(Quantity)	
FROM Production.ProductInventory
GROUP BY GROUPING SETS((LocationID), ())

-------------------------------------------------------------------------------------

--Question 16
SELECT pa.City,
COUNT(pa.AddressID) FROM Person.BusinessEntityAddress pb
JOIN Person.[Address] pa
ON pb.AddressID = pa.AddressID
GROUP BY pa.City
ORDER BY pa.City

-------------------------------------------------------------------------------------

--Question 17 
SELECT YEAR(OrderDate) AS just_year,
SUM(TotalDue)
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY just_year

-------------------------------------------------------------------------------------

--Question 18
SELECT DATEPART(YEAR, OrderDate) AS just_year,
SUM(TotalDue)
FROM Sales.SalesOrderHeader
WHERE DATEPART(YEAR, OrderDate) <= 2016
GROUP BY DATEPART(YEAR, OrderDate)
ORDER BY just_year

-------------------------------------------------------------------------------------

--Question 19
SELECT * FROM Person.ContactType WHERE Name LIKE '%Manager%'
ORDER BY ContactTypeID DESC

-------------------------------------------------------------------------------------

--Question 20
SELECT be.BusinessEntityID,
pp.LastName,
pp.FirstName
FROM Person.BusinessEntityContact be
JOIN Person.ContactType pc
ON pc.ContactTypeID = be.ContactTypeID
JOIN Person.Person pp
ON pp.BusinessEntityID = be.PersonID
WHERE pc.Name LIKE 'Purchasing Manager%'
ORDER BY pp.LastName, pp.FirstName

-------------------------------------------------------------------------------------

--Question 21
SELECT pp.LastName,
ss.SalesYTD,
pa.PostalCode,
ROW_NUMBER() OVER(PARTITION BY pa.PostalCode ORDER BY ss.SalesYTD DESC)
FROM Sales.SalesPerson ss
JOIN Person.Person pp
ON ss.BusinessEntityID = pp.BusinessEntityID
JOIN Person.BusinessEntityAddress pbe
ON pbe.BusinessEntityID = ss.BusinessEntityID
JOIN Person.Address pa
ON pa.AddressID = pbe.AddressID
WHERE ss.TerritoryID IS NOT NULL AND ss.SalesYTD <> 0
ORDER BY pa.PostalCode ASC

-------------------------------------------------------------------------------------

--Question 22
SELECT bec.ContactTypeID,
pc.[Name],
COUNT(bec.ContactTypeID) AS total_countofcontact
FROM Person.BusinessEntityContact bec
INNER JOIN Person.ContactType pc
ON pc.ContactTypeID = bec.ContactTypeID
GROUP BY pc.[Name], bec.ContactTypeID
HAVING COUNT(bec.ContactTypeID ) > 100
ORDER BY total_countofcontact DESC

-------------------------------------------------------------------------------------

--Question 23
SELECT CAST(ep.RateChangeDate AS date),
CONCAT_WS(',', pp.LastName, pp.FirstName, pp.MiddleName) AS full_name,
40 * ep.Rate
FROM HumanResources.EmployeePayHistory ep
INNER JOIN Person.Person pp
ON pp.BusinessEntityID = ep.BusinessEntityID
ORDER BY full_name ASC

-------------------------------------------------------------------------------------

--Question 24
SELECT CAST(eh.RateChangeDate AS date),
CONCAT_WS(',',pp.LastName, pp.FirstName, pp.MiddleName) AS Full_Name,
40 * eh.Rate AS Weekly_Salary
FROM Person.Person pp
INNER JOIN HumanResources.EmployeePayHistory eh
ON eh.BusinessEntityID = pp.BusinessEntityID
WHERE eh.RateChangeDate = (SELECT MAX(ph.RateChangeDate)
FROM HumanResources.EmployeePayHistory ph 
WHERE ph.BusinessEntityID = eh.BusinessEntityID)
ORDER BY Full_Name ASC

-------------------------------------------------------------------------------------

--Question 25
SELECT SalesOrderID,
ProductID,
OrderQty,
SUM(OrderQty) OVER(PARTITION BY SalesOrderID) AS row_sum,
AVG(OrderQty) OVER(PARTITION BY SalesOrderID) AS row_avg,
COUNT(OrderQty) OVER(PARTITION BY SalesOrderID) AS row_count,
MAX(OrderQty) OVER(PARTITION BY SalesOrderID) AS row_max,
MIN(OrderQty) OVER(PARTITION BY SalesOrderID) AS row_min
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN (43659, 43664)
ORDER BY SalesOrderID

-------------------------------------------------------------------------------------

--Question 26. I don't understand
SELECT SalesOrderID,
ProductID,
OrderQty,
SUM(OrderQty) OVER(ORDER BY SalesOrderID, ProductID) AS row_sum,
AVG(OrderQty) OVER(PARTITION BY SalesOrderID ORDER BY SalesOrderID, ProductID) AS average_sum,
COUNT(OrderQty) OVER(ORDER BY SalesOrderID, ProductID
ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING) AS row_count
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN(43659, 43664) AND ProductID LIKE '71%'
ORDER BY SalesOrderID

-------------------------------------------------------------------------------------

--Question 27
SELECT SalesOrderID,
SUM(OrderQty * UnitPrice)
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING SUM(OrderQty * UnitPrice) > 100000
ORDER BY SalesOrderID ASC

-------------------------------------------------------------------------------------

--Question 28
SELECT ProductID,
Name
FROM Production.Product 
WHERE Name LIKE 'Lock Washer%'
ORDER BY ProductID

-------------------------------------------------------------------------------------

--Question 29
SELECT ProductID,
Name,
Color
FROM Production.Product
ORDER BY ListPrice

-------------------------------------------------------------------------------------

--Question 30
SELECT BusinessEntityID,
JobTitle,
HireDate
FROM HumanResources.Employee
ORDER BY YEAR(HireDate)

-------------------------------------------------------------------------------------

--Question 31
SELECT LastName,
FirstName
FROM Person.Person
WHERE LastName LIKE 'R%'
ORDER BY FirstName ASC, LastName DESC

-------------------------------------------------------------------------------------

--Question 32
SELECT BusinessEntityID, 
SalariedFlag
FROM HumanResources.Employee
ORDER BY 
CASE SalariedFlag 
	WHEN 1 THEN BusinessEntityID
END
DESC
,
CASE 
	WHEN SalariedFlag = 0 THEN BusinessEntityID
END
ASC

-------------------------------------------------------------------------------------

--Question 33
SELECT sp.BusinessEntityID,
pp.LastName AS last_name,
st.Name AS territory_name,
cr.Name AS region_name
FROM Sales.SalesPerson sp
INNER JOIN Sales.SalesTerritory st
ON sp.TerritoryID = st.TerritoryID
INNER JOIN Person.CountryRegion cr
ON cr.CountryRegionCode = st.CountryRegionCode
INNER JOIN Person.Person pp
ON pp.BusinessEntityID = sp.BusinessEntityID

SELECT BusinessEntityID,
LastName,
TerritoryName,
CountryRegionName
FROM Sales.vSalesPerson
WHERE TerritoryName IS NOT NULL
ORDER BY 
	CASE CountryRegionName
	    WHEN 'United States' THEN CountryRegionName
		ELSE CountryRegionName 
	END
ASC

-------------------------------------------------------------------------------------

--Qusetion 34
SELECT pp.FirstName,
pp.LastName,
ROW_NUMBER() OVER(ORDER BY pa.PostalCode) AS Row_,
RANK() OVER(ORDER BY pa.PostalCode) AS Rank_,
DENSE_RANK() OVER(ORDER BY pa.PostalCode) AS Dense_Ranks,
NTILE(4) OVER(ORDER BY pa.PostalCode) AS Quartile,
sp.SalesYTD,
pa.PostalCode
FROM Sales.SalesPerson sp
INNER JOIN Person.Person pp
ON pp.BusinessEntityID = sp.BusinessEntityID
INNER JOIN Person.BusinessEntityAddress ba
ON ba.BusinessEntityID = pp.BusinessEntityID
INNER JOIN Person.Address pa
ON pa.AddressID = ba.BusinessEntityID
WHERE SalesYTD <> 0 AND sp.TerritoryID IS NOT NULL

SELECT * FROM Person.Person pp
JOIN  Sales.SalesPerson ss
ON pp.BusinessEntityID = ss.BusinessEntityID
JOIN Person.BusinessEntityAddress ea
ON ea.BusinessEntityID = ss.BusinessEntityID
JOIN Person.Address pa
ON pa.AddressID = ea.AddressID

-------------------------------------------------------------------------------------

--Question 35
SELECT * FROM HumanResources.Department
ORDER BY DepartmentID
OFFSET 10 ROWS

-------------------------------------------------------------------------------------

--Question 36
SELECT * FROM HumanResources.Department
ORDER BY DepartmentID
OFFSET 5 ROWS
FETCH NEXT 5 ROWS ONLY

-------------------------------------------------------------------------------------

--Question 37
SELECT Name,
Color,
ListPrice
FROM Production.Product
WHERE Color IN('Blue', 'Red')
ORDER BY ListPrice

-------------------------------------------------------------------------------------

--Question 38
SELECT pp.Name,
ss.SalesOrderID
FROM Production.Product pp
FULL OUTER JOIN Sales.SalesOrderDetail ss
ON pp.ProductID = ss.ProductID
ORDER BY pp.Name ASC

-------------------------------------------------------------------------------------

--Question 39
WITH Window_Testing AS
(
	SELECT pp.FirstName,
	pp.LastName,
	ROW_NUMBER() OVER(ORDER BY pa.PostalCode) AS Row_,
	RANK() OVER(ORDER BY pa.PostalCode) AS Rank_,
	DENSE_RANK() OVER(ORDER BY pa.PostalCode) AS Dense_Ranks,
	NTILE(4) OVER(ORDER BY pa.PostalCode) AS Quartile,
	sp.SalesYTD,
	pa.PostalCode
	FROM Sales.SalesPerson sp
	INNER JOIN Person.Person pp
	ON pp.BusinessEntityID = sp.BusinessEntityID
	INNER JOIN Person.BusinessEntityAddress ba
	ON ba.BusinessEntityID = pp.BusinessEntityID
	INNER JOIN Person.Address pa
	ON pa.AddressID = ba.BusinessEntityID
	WHERE SalesYTD <> 0 AND sp.TerritoryID IS NOT NULL
),
Function_Testing AS
(
	SELECT PostalCode,
	Quartile,
	ROW_NUMBER() OVER(PARTITION BY PostalCode ORDER BY Quartile) AS Row_Testing,
	RANK() OVER(PARTITION BY PostalCode ORDER BY Quartile) AS Rank_Testing,
	DENSE_RANK() OVER(PARTITION BY PostalCode ORDER BY Quartile) AS DenseRank_Testing,
	NTILE(2) OVER(PARTITION BY PostalCode ORDER BY Quartile) AS Ntile_Testing
	FROM Window_Testing
)
SELECT * FROM Function_Testing

SELECT OrderDate,
SubTotal,
LAG(SubTotal, 4, 100) OVER(ORDER BY OrderDate),
CASE
	WHEN (LAG(SubTotal) OVER(ORDER BY OrderDate)) = 0 THEN NULL
	ELSE (SubTotal - LAG(SubTotal) OVER(ORDER BY OrderDate)) * 100 /
	LAG(SubTotal) OVER(ORDER BY OrderDate) 
END
FROM Sales.SalesOrderHeader

-------------------------------------------------------------------------------------

--Question 40
SELECT pp.Name,
ss.SalesOrderID
FROM Production.Product pp
JOIN Sales.SalesOrderDetail ss
ON pp.ProductID = ss.ProductID
ORDER BY pp.Name

-------------------------------------------------------------------------------------

--Question 41
SELECT st.Name,
sp.BusinessEntityID
FROM Sales.SalesTerritory st
RIGHT JOIN Sales.SalesPerson sp
ON sp.TerritoryID = sp.TerritoryID
WHERE st.TerritoryID IS NOT NULL OR st.TerritoryID IS NULL

-------------------------------------------------------------------------------------

--Question 42
SELECT CONCAT_WS(' ,', pp.FirstName, pp.LastName),
pa.City
FROM Person.Person pp
JOIN HumanResources.Employee he
ON he.BusinessEntityID = pp.BusinessEntityID
JOIN Person.BusinessEntityAddress bea
ON bea.BusinessEntityID = he.BusinessEntityID
JOIN Person.Address pa
ON pa.AddressID = bea.AddressID
ORDER BY pp.LastName, pp.FirstName

-------------------------------------------------------------------------------------

--Question 43
SELECT BusinessEntityID,
FirstName,
LastName
FROM Person.Person
WHERE PersonType = 'IN' AND LastName = 'Adams'
ORDER BY FirstName ASC

-------------------------------------------------------------------------------------

--Question 44
SELECT BusinessEntityID,
FirstName,
LastName
FROM Person.Person
WHERE LastName LIKE 'Al%' AND FirstName LIKE 'M%' AND BusinessEntityID <= 1500

-------------------------------------------------------------------------------------

--Question 45
SELECT ProductID,
Name,
Color
FROM Production.Product
WHERE Name IN('Blade', 'Crown Race', 'AWC Logo Cap')

-------------------------------------------------------------------------------------

--Question 45
SELECT SalesOrderID,
LineTotal,
first_VALUE(LineTotal) OVER(PARTITION BY SalesOrderID ORDER BY LineTotal desc),
LineTotal-FIRST_VALUE(LineTotal) OVER(PARTITION BY SalesOrderID ORDER BY LineTotal)
FROM Sales.SalesOrderDetail

SELECT SalesOrderID,
LineTotal,
LAST_VALUE(LineTotal) OVER(PARTITION BY SalesOrderID ORDER BY LineTotal
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM Sales.SalesOrderDetail










