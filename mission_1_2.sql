--1.	�p��i���~�j��ƪ����O����2�����~��ƥ�������C
SELECT *
FROM Products
WHERE CategoryID = 2;

SELECT ROUND(AVG(UnitPrice), 0) AS avg_price
FROM Products
WHERE CategoryID = 2;


--2.	�b�i���~�j��ƪ���X�w�s�q�p��w���s�q�A�B�|���i����ʪ����~��ưO���C

SELECT *
FROM Products
WHERE UnitsInStock < ReorderLevel AND UnitsOnOrder = 0;


--3.	�b�i�q����ӡj��ƪ��X�q�椤�]�t�W�L5�ز��~����ưO���C
SELECT  OrderID
FROM OrderDetails
GROUP BY OrderID
HAVING COUNT(DISTINCT ProductID) > 5;


--3.2rd�Ѫk
SELECT od.OrderID, 
       STUFF((
           SELECT ', ' + CAST(ProductID AS VARCHAR(MAX))
           FROM OrderDetails od2
           WHERE od.OrderID = od2.OrderID
           ORDER BY ProductID
           FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '') AS ProductID_List
FROM (
    SELECT OrderID
    FROM OrderDetails
    GROUP BY OrderID
    HAVING COUNT(DISTINCT ProductID) > 5
) od;


--4.�b�i�q����ӡj��ƪ���ܥX�q�渹�X10263�Ҧ����~������p�p�C


SELECT 
    OrderID, 
    ProductID, 
    ROUND(SUM(UnitPrice * Quantity * (1 - Discount)), 0) AS Price_Subtotal
FROM OrderDetails
WHERE OrderID = 10263
GROUP BY OrderID, ProductID;

--5.	�Q�Ρi���~�j��ƪ��ơA�έp�X�C�@�Ө����ӦU���ѤF�X�˲��~�C
SELECT SupplierID, COUNT(ProductID) AS ���Ѳ��~�ƶq
FROM Products
GROUP BY SupplierID;

--6.	�Q�Ρi�q��j��ƪ��ơA�έp�X�C�@��Ȥ�Q�C�@����u�ҪA�Ȧ��ơC

SELECT CustomerID, EmployeeID, COUNT(EmployeeID) AS times
FROM Orders
GROUP BY CustomerID, EmployeeID;
--6-2�Ѫk
SELECT CustomerID, EmployeeID, COUNT (*) AS times
FROM Orders
GROUP BY CustomerID, EmployeeID;



---7.�Q�Ρi�q����ӡj��ƪ��ơA�έp�X�U���ӫ~����������P�����P��ƶq�A�æC�X�����P��ƶq�j��10����ơA�B�N��ƨ̲��~�s���Ѥp��j�ƧǡC

SELECT 
    ProductID, 
    ROUND(AVG(UnitPrice), 0) AS avg_unit_price, 
    ROUND(AVG(Quantity), 0) AS avg_sale_quantity
FROM OrderDetails
GROUP BY ProductID
HAVING AVG(Quantity) > 10
ORDER BY ProductID ;


