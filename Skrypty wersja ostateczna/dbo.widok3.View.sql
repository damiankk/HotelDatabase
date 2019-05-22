USE [Grupa_2]
GO
/****** Object:  View [dbo].[widok3]    Script Date: 22/05/2019 19:02:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[widok3] as
SELECT KLIENT.Imie, KLIENT.Nazwisko, REZERWACJA.PoczatekPobytu, REZERWACJA.KoniecPobytu, HOTEL.NumerHotelu, HOTEL.Miasto, POKOJ.NumerPokoju
FROM POKOJ INNER JOIN
REZERWACJA ON POKOJ.IdPokoju = REZERWACJA.IdPokoju INNER JOIN
HOTEL ON POKOJ.IdHotelu = HOTEL.idHotelu INNER JOIN
KLIENT ON REZERWACJA.IdKlienta = KLIENT.IdKlienta
GO
