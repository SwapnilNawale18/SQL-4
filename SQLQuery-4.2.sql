--Day 16.1
use AdventureWorks2012;

ALTER DATABASE AdventureWorks2012
ADD FILE
( 
NAME = 'AdventureWorks1.ndf',
FILENAME = 'C:\FileGroups\AdventureWorks1.ndf',
SIZE = 5MB,
MAXSIZE = 100MB,
FILEGROWTH = 5MB
)
TO FILEGROUP First

ALTER DATABASE AdventureWorks2012
ADD FILE
( 
NAME = 'AdventureWorks2.ndf',
FILENAME = 'C:\FileGroups\AdventureWorks2.ndf',
SIZE = 5MB,
MAXSIZE = 100MB,
FILEGROWTH = 5MB
)
TO FILEGROUP Second

ALTER DATABASE AdventureWorks2012
ADD FILE
( 
NAME = 'AdventureWorks3.ndf',
FILENAME = 'C:\FileGroups\AdventureWorks3.ndf',
SIZE = 5MB,
MAXSIZE = 100MB,
FILEGROWTH = 5MB
)
TO FILEGROUP Third

ALTER DATABASE AdventureWorks2012
ADD FILE
( 
NAME = 'AdventureWorks4.ndf',
FILENAME = 'C:\FileGroups\AdventureWorks4.ndf',
SIZE = 5MB,
MAXSIZE = 100MB,
FILEGROWTH = 5MB
)
TO FILEGROUP Fourth

create partition function RateChngeDate(DateTime)
as range right for values
('1996-01-01','2000-01-01','2004-01-01','2008-01-01')

--create scheme will be on a function
create partition scheme RateChngeDate
as Partition RateChngeDate
To (Old,First,Second,Third,Fourth)

-- creating table on scheme
Create table EmpPayHistPart
(
EmployeeId int,
RateChangeDate datetime,
Rate money,
PayFrequency tinyint,
ModifiedDate datetime
)on RateChngeDate(RateChangeDate)


--Delete This files if Enterprise Edition of Server is required is displayed
--Delete Files
USE master;  
GO  
ALTER DATABASE AdventureWorks2012  
REMOVE FILE AdventureWorks1;
ALTER DATABASE AdventureWorks2012  
REMOVE FILE AdventureWorks2;
ALTER DATABASE AdventureWorks2012  
REMOVE FILE AdventureWorks3;
ALTER DATABASE AdventureWorks2012  
REMOVE FILE AdventureWorks4;
GO

--Delete Filegroup
USE master;
GO  
ALTER DATABASE AdventureWorks2012  
REMOVE FILEGROUP Fourth;  
GO
