CREATE PROCEDURE Sum_for_Products_Salse_Pivot2
    @Year INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartDate DATE = DATEFROMPARTS(@Year, 1, 1);
    DECLARE @EndDate DATE = DATEFROMPARTS(@Year, 12, 31);

    SELECT 
        ISNULL(pvt.���~�s��, '') AS ���~�s��,
        ISNULL(p.���~, '') AS ���~�W��,
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
            od.���~�s��, 
            ISNULL(ROUND(SUM((od.��� * od.�ƶq - od.�馩)), 0), 0) AS �P���B, 
            MONTH(o.�q����) AS ���
        FROM 
            �q�f���� AS od 
            INNER JOIN �q�f�D�� AS o ON od.�q�渹�X = o.�q�渹�X
        WHERE 
            o.�q���� >= @StartDate AND o.�q���� <= @EndDate
        GROUP BY 
            od.���~�s��, 
            MONTH(o.�q����)
        ) AS t
    PIVOT
    (
        SUM(�P���B)
        FOR ��� IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
    ) AS pvt
    LEFT JOIN ���~��� AS p ON pvt.���~�s�� = p.���~�s��
    ORDER BY 
        ���~�s��;

END;

EXEC Sum_for_Products_Salse_Pivot2 @Year = 1997;