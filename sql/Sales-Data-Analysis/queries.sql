-- Total Sales by Customer
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    SUM(o.TotalAmount) AS TotalSpent
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID, c.FirstName, c.LastName
ORDER BY 
    TotalSpent DESC;

-- Top-Selling Products

SELECT 
    p.ProductName,
    SUM(s.Quantity) AS TotalQuantitySold,
    SUM(s.SaleAmount) AS TotalRevenue
FROM 
    Sales s
JOIN 
    Products p ON s.ProductID = p.ProductID
GROUP BY 
    p.ProductName
ORDER BY 
    TotalRevenue DESC;

-- Sales by Country

SELECT 
    c.Country,
    SUM(o.TotalAmount) AS TotalSales
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
GROUP BY 
    c.Country
ORDER BY 
    TotalSales DESC;

-- Monthly Sales Trend

SELECT 
    DATE_FORMAT(OrderDate, '%Y-%m') AS Month,
    SUM(TotalAmount) AS MonthlySales
FROM 
    Orders
GROUP BY 
    Month
ORDER BY 
    Month;
