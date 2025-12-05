USE master 
GO
CREATE DATABASE RevelstokeMountainResort
GO
USE RevelstokeMountainResort
GO

EXEC sp_configure filestream_access_level, 2 RECONFIGURE

ALTER DATABASE RevelstokeMountainResort
ADD FILEGROUP FG_Images CONTAINS FILESTREAM
GO
ALTER DATABASE RevelstokeMountainResort
ADD FILE (
	NAME = FG_Images,
	FILENAME = 'C:\EspaceLabo\FG_Images_2386452'
)
TO FILEGROUP FG_Images