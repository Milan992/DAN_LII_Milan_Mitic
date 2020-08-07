IF DB_ID('Cake') IS NULL
CREATE DATABASE Cake
GO
USE Cake;


if exists (SELECT name FROM sys.sysobjects WHERE name = 'tblRecord')
drop table tblRecord;

if exists (SELECT name FROM sys.sysobjects WHERE name = 'tblOrder')
drop table tblOrder;

if exists (SELECT name FROM sys.sysobjects WHERE name = 'tblAccount')
drop table tblAccount;

if exists (SELECT name FROM sys.sysobjects WHERE name = 'tblCake')
drop table tblCake;

if exists (SELECT name FROM sys.sysobjects WHERE name = 'tblCakeType')
drop table tblCakeType;


create table tblAccount(
AccountID int identity(1,1) primary key,
FullName varchar(30) not null,
PhoneNumber varchar(30) not null,
UserName varchar(30) check(len(UserName) > 5) not null unique,
Pass varchar(30) check(len(Pass) > 5) not null,
constraint checkPhoneNumber check(PhoneNumber not like '%[^0-9]%')
)

Create table tblCakeType (
CakeTypeID int identity (1,1) primary key,
CakeType varchar(10)
)

Create table tblCake (
CakeID int identity (1,1) primary key,
CakeName varchar(10) not null,
PurchasePrice int not null,
SellingPrice int not null,
CakeTypeID int foreign key (CakeTypeID) references tblCakeType(CakeTypeID),
)

create table tblOrder(
OrderID int identity(1,1) primary key,
AccountID int foreign key (AccountID) references tblAccount(AccountID) not null,
DateAndTime datetime not null,
Price int
)

create table tblRecord(
RecordID int identity(1,1) primary key,
OrderID int foreign key (OrderID) references tblOrder(OrderID) not null,
CakeID int foreign key (CakeID) references tblCake(CakeID) not null,
Amount int not null
)


insert into tblCakeType(CakeType)
values ('adults');

insert into tblCakeType(CakeType)
values ('kids');
