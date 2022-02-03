-- �.�. ��������� �� � ������ � ������� �� ����, �������� ���� ������� ���� �� ��������
-- ��� ������ � �����
use master;
go
if exists (select 1 from sys.databases where name = 'ProductCategory')
begin
	print 'Delete existing database'
	alter database PLSE_New SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	drop database ProductCategory
end
go 

create database ProductCategory
on
(Name = 'ProductCategory',
filename = 'd:\TestDB\ProductCategory.mdf',
size = 10,
maxsize = 40,
filegrowth = 5)
log on
(Name = 'ProductCategory_Log',
filename = 'd:\TestDB\ProductCategory.ldf',
size = 10,
maxsize = 40,
filegrowth = 5
)
go

use ProductCategory

--SETTLEMENTS
create table tblProducts(
ProductID int identity(1,1) not null
	primary key,
Title nvarchar(200) not null
);
go

insert into tblProducts(Title)
values ('������ Parmalat 1.8% ������������ 1�'), 
		('�������-������� Schauma Kids ��� ���� 350��'),
		('���� Cesar �������� � ������� 85�'), -- ��� ��������� 
		('������� �������� �� ������� ������������ 400�'),
		('������� ��������� ���������� �/� ������������ 350�'), 
		('���� ������ ������ �������� ����� 0.45�');
go

--CATEGORY
create table tblCategories(
CategoryID int identity(1,1) not null
	primary key,
Title nvarchar(40) not null
	unique
);
go

insert into tblCategories(Title)
values ('��������'),
		('��������'),
		('������� �����'),
		('�������'),
		('�����'),
		('���������� ��������');
go

--PRODUCT_CATEGORY
create table tblProducts_Categories(
ProductCategoryID int identity(1,1) not null
	primary key,
ProductID int not null
	foreign key references tblProducts(ProductID),
CategoryID int not null
	foreign key references tblCategories(CategoryID)
constraint u_ProductCategory unique(ProductID, CategoryID)
);
go

insert into tblProducts_Categories(ProductID, CategoryID)
values (1, 1), (1,4),
		(2, 3), (2,5),
		(4,1),
		(5,1),(5,5),(5,6),
		(6,2), (6,4);
go

-- ��� ������
select p.Title, c.Title
from tblProducts as p
left join tblProducts_Categories as pc
	on p.ProductID = pc.ProductID
left join tblCategories as c
	on c.CategoryID = pc.CategoryID;