--1
CREATE DATABASE HW2DDL;
--2
CREATE TABLE 學生資料 (
    學號 CHAR(10) NOT NULL PRIMARY KEY,
    姓名 NVARCHAR(20) NOT NULL,
    電話 VARCHAR(20) NOT NULL,
    地址 NVARCHAR(100) NOT NULL,
    生日 DATETIME
)
--
CREATE TABLE 課程資料 (
    課程代碼 CHAR(6) NOT NULL PRIMARY KEY,
    課程名稱 NVARCHAR(30) NOT NULL,
    學分數 INT NOT NULL DEFAULT 3
);

--3
-- Orders 表
CREATE TABLE 訂單資料表 (
    訂單代號 char(12) PRIMARY KEY,
    訂購日期 datetime NOT NULL
);
go

-- OrderDetails 表
CREATE TABLE 訂單明細表 (
    訂單代號 char(12),
    產品編號 char(6),
    購買數量 int NOT NULL,
    售價 money NOT NULL,
    PRIMARY KEY (訂單代號, 產品編號),
    FOREIGN KEY (訂單代號) REFERENCES 訂單資料表(訂單代號) on delete cascade,
    FOREIGN KEY (產品編號) REFERENCES 產品資料表(產品編號) on delete no action on update cascade
);
go

-- Products 表
CREATE TABLE 產品資料表 (
    產品編號 char(6) PRIMARY KEY,
    產品名稱 nvarchar(50) NOT NULL
);
go