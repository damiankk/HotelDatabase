USE [Grupa_2]
GO
/****** Object:  StoredProcedure [dbo].[Procedura3]    Script Date: 22/05/2019 19:02:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Procedura3] 
AS
BEGIN
	SET NOCOUNT ON;
	Update REZERWACJA
	Set ZakonczonyPobyt = 'tak'
	WHERE KoniecPobytu < getdate()

	Update REZERWACJA
	Set ZakonczonyPobyt = 'nie'
	WHERE KoniecPobytu > getdate()
END
GO
