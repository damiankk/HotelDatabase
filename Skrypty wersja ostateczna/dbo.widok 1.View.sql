USE [Grupa_2]
GO
/****** Object:  View [dbo].[widok 1]    Script Date: 22/05/2019 19:02:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[widok 1]
as SELECT PRACOWNIK.Imie, PRACOWNIK.Nazwisko, STANOWISKO.Pensja, STANOWISKO.NazwaStanowiska
FROM PRACOWNIK INNER JOIN
STANOWISKO ON PRACOWNIK.IdStanowiska = STANOWISKO.IdStanowiska;
GO
