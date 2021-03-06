USE [Grupa_2]
GO
/****** Object:  View [dbo].[widok4]    Script Date: 22/05/2019 19:02:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[widok4] AS
SELECT H.NumerHotelu, H.Miasto, COUNT(*) AS LiczbaPracownikow FROM PRACOWNIK P
INNER JOIN HOTEL H ON H.idHotelu=P.IdHotelu
INNER JOIN STANOWISKO S ON P.IdStanowiska=S.IdStanowiska
WHERE S.Pensja > 4000
GROUP BY H.NumerHotelu, H.Miasto;
GO
