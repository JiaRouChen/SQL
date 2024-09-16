CREATE PROCEDURE Sum_for_Products_Sales_Pivot
    @Year INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SQLQuery AS NVARCHAR(MAX)

    -- �ʺA�ͦ� pivot �d�߻y�y
    SET @SQLQuery = N'
    SELECT ProductName,
           ROUND(ISNULL([1], 0), 2) AS "1��",
           ROUND(ISNULL([2], 0), 2) AS "2��",
           ROUND(ISNULL([3], 0), 2) AS "3��",
           ROUND(ISNULL([4], 0), 2) AS "4��",
           ROUND(ISNULL([5], 0), 2) AS "5��",
           ROUND(ISNULL([6], 0), 2) AS "6��",
           ROUND(ISNULL([7], 0), 2) AS "7��",
           ROUND(ISNULL([8], 0), 2) AS "8��",
           ROUND(ISNULL([9], 0), 2) AS "9��",
           ROUND(ISNULL([10], 0), 2) AS "10��",
           ROUND(ISNULL([11], 0), 2) AS "11��",
           ROUND(ISNULL([12], 0), 2) AS "12��"
    FROM (
        SELECT p.ProductName,
               MONTH(o.OrderDate) AS OrderMonth,
               ROUND(SUM((od.UnitPrice * od.Quantity) - (od.UnitPrice * od.Quantity * (od.Discount / 100))), 0) AS TotalSales
        FROM Northwind.dbo.Products p
        INNER JOIN Northwind.dbo.[OrderDetails] od ON p.ProductID = od.ProductID
        INNER JOIN Northwind.dbo.Orders o ON od.OrderID = o.OrderID
        WHERE YEAR(o.OrderDate) = ' + CAST(@Year AS NVARCHAR(4)) + '
        GROUP BY p.ProductName, MONTH(o.OrderDate)
    ) AS SalesData
    PIVOT (
        SUM(TotalSales)
        FOR OrderMonth IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
    ) AS PivotTable
    ORDER BY ProductName;
    '

    -- ����ʺA�ͦ��� SQL �d��
    EXEC sp_executesql @SQLQuery

END;

--����d��
EXEC Sum_for_Products_Sales_Pivot @Year = 1997; --�D�حn�x
EXEC Sum_for_Products_Sales_Pivot @Year = 1996;
EXEC Sum_for_Products_Sales_Pivot @Year = 1998;