USE [Grupa_2]
GO
/****** Object:  View [dbo].[widok2]    Script Date: 22/05/2019 19:02:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[widok2] as
SELECT KLIENT.Imie, KLIENT.Nazwisko, STATUS_KLIENTA.NazwaStatusu, STATUS_KLIENTA.ZnizkaProcentowa, STATUS_KLIENTA.CzyWliczoneSniadania
FROM KLIENT INNER JOIN
STATUS_KLIENTA ON KLIENT.IdStatusu = STATUS_KLIENTA.IdStatusu;
GO
