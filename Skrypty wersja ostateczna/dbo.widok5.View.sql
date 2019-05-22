USE [Grupa_2]
GO
/****** Object:  View [dbo].[widok5]    Script Date: 22/05/2019 19:02:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[widok5] as
SELECT K.Nazwisko, COUNT(*) AS LiczbaRezerwacji FROM KLIENT K
INNER JOIN REZERWACJA R ON K.IdKlienta = R.IdKlienta
GROUP BY K.Nazwisko;
GO
