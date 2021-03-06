USE [Grupa_2]
GO
/****** Object:  UserDefinedFunction [dbo].[funkcja4]    Script Date: 22/05/2019 19:02:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[funkcja4] (
@IdRestauracji int)
RETURNS int
AS
BEGIN
DECLARE @result int
SET @result = (SELECT COUNT(*) AS LiczbaPotrawBezglutenowych FROM RESTAURACJA_POTRAWA R
INNER JOIN POTRAWA P ON R.IdPotrawy = P.IdPotrawy 
WHERE R.IdRestauracji = @IdRestauracji AND P.CzyGluten = 0
);
RETURN @result
END
GO
