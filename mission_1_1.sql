
--1.	�b�i���u�j��ƪ���X�Ҧ��k�ʭ��u����ơC
SELECT *
FROM Employees
WHERE TitleOfCourtesy IN ('Mr.', 'Dr.'); --Dr.�u���@�ӥB�Ƶ���his


--2.	�b�i���u�j��ƪ���X�Ҧ��b1993�~(�t)�H���¾����ơC
SELECT *
FROM Employees
WHERE HireDate >= '1993-01-01';

--3.	�b�i�q��j��ƪ��X�e�f�l���ϸ���44087�P05022��82520����ơC
SELECT *
FROM Orders
WHERE ShipPostalCode IN ('44087', '05022', '82520');

--4.	�b�i���~�j��ƪ���X�w�s�q�̦h���e6�W��ưO���C
SELECT  *
FROM Products

SELECT TOP 6 WITH TIES *
FROM Products
ORDER BY UnitsInStock DESC;


--5.	��X�q�渹�X10847���q�ʲ��~���ӡ]����join���~��ơ^�C
SELECT *
FROM OrderDetails
WHERE OrderID = 10847;

--6.	�b�i�q��j��ƪ���X�|�����e�f������O����ơC
SELECT *
FROM Orders
WHERE ShippedDate IS NULL;

--7.	�b�i�q��W�ӡj��ƪ���X�q�ʪ����~�ƶq����20~40�󪺸�ưO���C
SELECT *
FROM OrderDetails
WHERE Quantity BETWEEN 20 AND 40;
