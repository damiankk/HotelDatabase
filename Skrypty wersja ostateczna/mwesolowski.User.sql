USE [Grupa_2]
GO
/****** Object:  User [mwesolowski]    Script Date: 22/05/2019 19:02:46 ******/
CREATE USER [mwesolowski] FOR LOGIN [mwesolowski] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [mwesolowski]
GO
ALTER ROLE [db_datareader] ADD MEMBER [mwesolowski]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [mwesolowski]
GO
