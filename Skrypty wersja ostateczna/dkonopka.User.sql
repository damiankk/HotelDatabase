USE [Grupa_2]
GO
/****** Object:  User [dkonopka]    Script Date: 22/05/2019 19:02:46 ******/
CREATE USER [dkonopka] FOR LOGIN [dkonopka] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [dkonopka]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [dkonopka]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [dkonopka]
GO
ALTER ROLE [db_datareader] ADD MEMBER [dkonopka]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [dkonopka]
GO
