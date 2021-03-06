USE [Grupa_2]
GO
/****** Object:  UserDefinedFunction [dbo].[funkcja3]    Script Date: 22/05/2019 19:02:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[funkcja3] (
@NumerHotelu int)
RETURNS int
AS
BEGIN
DECLARE @result int
SET @result = (SELECT COUNT(*) AS LiczbaPokoiWHotelu FROM HOTEL H
INNER JOIN POKOJ P ON P.IdHotelu = H.idHotelu
WHERE P.IdHotelu = @NumerHotelu
);
RETURN @result
END
GO
