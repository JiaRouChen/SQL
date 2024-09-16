SELECT 
    EmployeeID,
    FirstName + ' ' + LastName AS EmployeeName,
    Title,
    Extension,
    Notes
FROM 
    Employees
WHERE 
    EmployeeID IN (
        SELECT DISTINCT EmployeeID
        FROM Orders
    );
--------------------------------------------------------------------------------老師解法
	SELECT 
    e.EmployeeID,
    e.FirstName + e.LastName AS EmployeeName,
    e.Title,
    e.Extension,
    e.Notes
FROM 
    Employees as e
WHERE 
    e.EmployeeID IN (
        SELECT  EmployeeID
        FROM Orders
    );