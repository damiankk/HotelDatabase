USE [Grupa_2]
GO
/****** Object:  StoredProcedure [dbo].[Procedura5]    Script Date: 22/05/2019 19:02:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Procedura5] 
@IdHotelu int,
@IdKategorii int,
@nowaCena int
AS
BEGIN
	SET NOCOUNT ON;
	Update POKOJ
	Set CenaPokoju = @nowaCena
	WHERE IdKategorii = @IdKategorii and IdHotelu = @IdHotelu
END
GO
