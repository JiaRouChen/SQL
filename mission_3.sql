--1
CREATE DATABASE HW2DDL;
--2
CREATE TABLE �ǥ͸�� (
    �Ǹ� CHAR(10) NOT NULL PRIMARY KEY,
    �m�W NVARCHAR(20) NOT NULL,
    �q�� VARCHAR(20) NOT NULL,
    �a�} NVARCHAR(100) NOT NULL,
    �ͤ� DATETIME
)
--
CREATE TABLE �ҵ{��� (
    �ҵ{�N�X CHAR(6) NOT NULL PRIMARY KEY,
    �ҵ{�W�� NVARCHAR(30) NOT NULL,
    �Ǥ��� INT NOT NULL DEFAULT 3
);

--3
-- Orders ��
CREATE TABLE �q���ƪ� (
    �q��N�� char(12) PRIMARY KEY,
    �q�ʤ�� datetime NOT NULL
);
go

-- OrderDetails ��
CREATE TABLE �q����Ӫ� (
    �q��N�� char(12),
    ���~�s�� char(6),
    �ʶR�ƶq int NOT NULL,
    ��� money NOT NULL,
    PRIMARY KEY (�q��N��, ���~�s��),
    FOREIGN KEY (�q��N��) REFERENCES �q���ƪ�(�q��N��) on delete cascade,
    FOREIGN KEY (���~�s��) REFERENCES ���~��ƪ�(���~�s��) on delete no action on update cascade
);
go

-- Products ��
CREATE TABLE ���~��ƪ� (
    ���~�s�� char(6) PRIMARY KEY,
    ���~�W�� nvarchar(50) NOT NULL
);
go