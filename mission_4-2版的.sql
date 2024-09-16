CREATE PROCEDURE Sum_for_Products_Salse_Pivot3
    @Year INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartDate DATE = DATEFROMPARTS(@Year, 1, 1);
    DECLARE @EndDate DATE = DATEFROMPARTS(@Year, 12, 31);

    SELECT 
        ISNULL(pvt.ProductID, '') AS ���~�s��,
        ISNULL(p.ProductName, '') AS ���~�W��,
        ISNULL([1], 0) AS [1��],
        ISNULL([2], 0) AS [2��],
        ISNULL([3], 0) AS [3��],
        ISNULL([4], 0) AS [4��],
        ISNULL([5], 0) AS [5��],
        ISNULL([6], 0) AS [6��],
        ISNULL([7], 0) AS [7��],
        ISNULL([8], 0) AS [8��],
        ISNULL([9], 0) AS [9��],
        ISNULL([10], 0) AS [10��],
        ISNULL([11], 0) AS [11��],
        ISNULL([12], 0) AS [12��]
    FROM 
        (
        SELECT 
            od.ProductID, 
            ISNULL(ROUND(SUM((od.UnitPrice * od.Quantity - od.Discount)), 0), 0) AS �P���B, 
            MONTH(o.OrderDate) AS ���
        FROM 
            [OrderDetails] AS od 
            INNER JOIN Orders AS o ON od.OrderID = o.OrderID
        WHERE 
            o.OrderDate >= @StartDate AND o.OrderDate <= @EndDate
        GROUP BY 
            od.ProductID, 
            MONTH(o.OrderDate)
        ) AS t
    PIVOT
    (
        SUM(�P���B)
        FOR ��� IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
    ) AS pvt
    LEFT JOIN Products AS p ON pvt.ProductID = p.ProductID
    ORDER BY 
        ���~�s��;

END;

EXEC Sum_for_Products_Salse_Pivot3 @Year = 1997;