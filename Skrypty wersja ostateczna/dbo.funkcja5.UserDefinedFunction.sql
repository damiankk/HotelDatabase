USE [Grupa_2]
GO
/****** Object:  UserDefinedFunction [dbo].[funkcja5]    Script Date: 22/05/2019 19:02:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[funkcja5] (
@IdRestauracji int)
RETURNS int
AS
BEGIN
DECLARE @liczbaGodzin1 int
DECLARE @liczbaGodzin2 int
DECLARE @result int
SET @liczbaGodzin1 = (SELECT R.GodzinaOtwarcia FROM RESTAURACJA R
WHERE R.IdRestauracji = @IdRestauracji);
SET @liczbaGodzin2 = (SELECT R.GodzinaZamkniecia FROM RESTAURACJA R
WHERE R.IdRestauracji = @IdRestauracji);
SET @result = @liczbaGodzin2 - @liczbaGodzin1
RETURN @result
END
GO
