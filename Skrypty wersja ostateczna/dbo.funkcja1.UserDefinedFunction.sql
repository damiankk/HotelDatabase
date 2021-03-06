USE [Grupa_2]
GO
/****** Object:  UserDefinedFunction [dbo].[funkcja1]    Script Date: 22/05/2019 19:02:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[funkcja1](@miesiac int)
RETURNS @result TABLE
(
	NumerHotelu int,
	LiczbaWizyt int
)
AS
BEGIN

INSERT INTO @result(NumerHotelu, LiczbaWizyt)
SELECT H.NumerHotelu, COUNT(*) FROM REZERWACJA R
INNER JOIN POKOJ P ON R.IdPokoju = P.IdPokoju
INNER JOIN HOTEL H ON P.IdHotelu = H.idHotelu
WHERE MONTH(R.PoczatekPobytu) = @miesiac AND R.KoniecPobytu < getdate()
GROUP BY H.NumerHotelu

RETURN
END
GO
