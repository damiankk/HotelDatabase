USE [Grupa_2]
GO
/****** Object:  UserDefinedFunction [dbo].[funkcja2]    Script Date: 22/05/2019 19:02:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[funkcja2](@miesiac int)
RETURNS @result TABLE 
(
	Nazwisko varchar(60),
	IloscDyzurow int
)
AS
BEGIN

INSERT INTO @result(Nazwisko, IloscDyzurow)
SELECT P.Nazwisko, Count(*) from Dyzur D
inner join Pracownik P ON D.IdPracownika = P.IdPracownika
where MONTH(D.dyzurOd) = @miesiac
group by P.Nazwisko
RETURN
END
GO
