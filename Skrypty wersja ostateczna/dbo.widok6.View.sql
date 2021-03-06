USE [Grupa_2]
GO
/****** Object:  View [dbo].[widok6]    Script Date: 22/05/2019 19:02:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE VIEW [dbo].[widok6] as
  SELECT SUM(P.CenaPokoju) AS SumaCenPokoju, H.NumerHotelu FROM POKOJ P
  INNER JOIN REZERWACJA R ON P.IdPokoju=R.IdPokoju
  INNER JOIN HOTEL H ON H.idHotelu=P.IdHotelu
  GROUP BY H.NumerHotelu;
GO
