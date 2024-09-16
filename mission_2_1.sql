
	SELECT 
    o.OrderID,
	od.ProductID,
	od.Discount,
	c.CategoryName,
    p.ProductName,
    ROUND(od.UnitPrice, 0) AS UnitPrice,
    od.Quantity AS OrderQuantity,
    ROUND((od.UnitPrice * od.Quantity*(1-od.Discount)), 0) AS TotalPrice,
    cu.CustomerID,
    cu.ContactName AS Customer_Contact_Name,
    o.ShipName AS Ship_ReceiverName,
    o.OrderDate,
    CONCAT(e.FirstName, ' ', e.LastName) AS Deal_Case_EmployeeFullName,
    s.CompanyName AS ShippingCompany,
    su.CompanyName AS SupplierName
FROM 
    orders o
LEFT JOIN 
    orderdetails od ON o.OrderID = od.OrderID
INNER JOIN 
    Products p ON od.ProductID = p.ProductID
INNER JOIN 
    categories c ON p.CategoryID = c.CategoryID
INNER JOIN 
    Customers cu ON o.CustomerID = cu.CustomerID
LEFT JOIN 
    employees e ON o.EmployeeID = e.EmployeeID
INNER JOIN 
    shippers s ON o.ShipVia = s.ShipperID
INNER JOIN 
    suppliers su ON p.SupplierID = su.SupplierID
WHERE 
    YEAR(o.OrderDate) = 1996 
    AND MONTH(o.OrderDate) = 7 
    AND (od.OrderID IS NULL OR s.CompanyName = 'United Package');
	--------------------------------------------------------------------老師解法
SELECT          Orders.OrderID, Categories.CategoryName, Products.ProductName, OrderDetails.UnitPrice, OrderDetails.Quantity, 
			    round(OrderDetails.UnitPrice*OrderDetails.Quantity*(1-OrderDetails.Discount),0) as 小計,
                            Customers.CustomerID, Customers.CompanyName, Orders.ShipName, Orders.OrderDate, 
							Employees.LastName+Employees.FirstName as EmployeeName,
                             Shippers.CompanyName AS ShipperName, Suppliers.CompanyName AS SupplierName
FROM              Orders INNER JOIN
                            Customers ON Orders.CustomerID = Customers.CustomerID INNER JOIN
                            Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                            OrderDetails ON Orders.OrderID = OrderDetails.OrderID INNER JOIN
                            Products ON OrderDetails.ProductID = Products.ProductID INNER JOIN
                            Categories ON Products.CategoryID = Categories.CategoryID INNER JOIN
                            Shippers ON Orders.ShipVia = Shippers.ShipperID INNER JOIN
                            Suppliers ON Products.SupplierID = Suppliers.SupplierID
where Orders.OrderDate between '1996-7-1' and '1996-7-31' and Shippers.CompanyName='United Package'
