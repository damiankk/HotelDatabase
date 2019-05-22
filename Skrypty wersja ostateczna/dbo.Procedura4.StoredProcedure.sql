USE [Grupa_2]
GO
/****** Object:  StoredProcedure [dbo].[Procedura4]    Script Date: 22/05/2019 19:02:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Procedura4]
@IdRezerwacji int,
@IleSkracamy int
AS
BEGIN
	SET NOCOUNT ON;
	Update REZERWACJA
	Set KoniecPobytu = DATEADD(DD,-@ileSkracamy,KoniecPobytu)
	WHERE IdRezerwacji = @IdRezerwacji
END
GO
