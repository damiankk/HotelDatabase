USE [Grupa_2]
GO
/****** Object:  User [llaszuk]    Script Date: 22/05/2019 19:02:46 ******/
CREATE USER [llaszuk] FOR LOGIN [llaszuk] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [llaszuk]
GO
ALTER ROLE [db_datareader] ADD MEMBER [llaszuk]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [llaszuk]
GO
