USE SalesDB; 

-- make a copy of Orders table as a Temp table 
SELECT 
    *
INTO #Orders
FROM Sales.Orders


-- now display the data from the temp table 
SELECT  
    *
FROM #Orders



DELETE 
FROM #Orders
WHERE OrderStatus = 'Delivered'

SELECT 
    *
FROM #Orders
-- AFTER MAKING MANIPUTLATION WE NEED TO TRANSFER THIS TEMP TABLE TO SALES DATABASE 


SELECT 
    *
INTO Sales.ShippedOrders
FROM #Orders


SELECT 
    *
FROM Sales.ShippedOrders

/*Steps: 
#1 Step: Load Data To Temp Table 
#2 step: Transform Data in Temp Table
#3 step: Load Temp Table Into Permanent Table
*/

