USE [s16guest63]
GO
/****** Object:  User [s16guest63]    Script Date: 5/5/2016 8:28:52 PM ******/
CREATE USER [s16guest63] FOR LOGIN [s16guest63] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [s16guest63]
GO
ALTER ROLE [db_datareader] ADD MEMBER [s16guest63]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [s16guest63]
GO
