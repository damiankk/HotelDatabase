USE [Grupa_2]
GO
/****** Object:  UserDefinedFunction [dbo].[funkcja1]    Script Date: 24/04/2019 10:37:56 ******/
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
/****** Object:  UserDefinedFunction [dbo].[funkcja2]    Script Date: 24/04/2019 10:37:56 ******/
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
/****** Object:  UserDefinedFunction [dbo].[funkcja3]    Script Date: 24/04/2019 10:37:56 ******/
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
/****** Object:  UserDefinedFunction [dbo].[funkcja4]    Script Date: 24/04/2019 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[funkcja4] (
@IdRestauracji int)
RETURNS int
AS
BEGIN
DECLARE @result int
SET @result = (SELECT COUNT(*) AS LiczbaPotrawBezglutenowych FROM RESTAURACJA_POTRAWA R
INNER JOIN POTRAWA P ON R.IdPotrawy = P.IdPotrawy 
WHERE R.IdRestauracji = @IdRestauracji AND P.CzyGluten = 0
);
RETURN @result
END
GO
/****** Object:  UserDefinedFunction [dbo].[funkcja5]    Script Date: 24/04/2019 10:37:56 ******/
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
/****** Object:  Table [dbo].[PRACOWNIK]    Script Date: 24/04/2019 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRACOWNIK](
	[IdPracownika] [int] IDENTITY(1,1) NOT NULL,
	[PESEL] [varchar](11) NOT NULL,
	[Imie] [varchar](60) NULL,
	[Nazwisko] [varchar](60) NULL,
	[NumerTelefonu] [varchar](60) NULL,
	[UmowaOd] [datetime] NULL,
	[UmowaDo] [datetime] NULL,
	[IdHotelu] [int] NULL,
	[IdStanowiska] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPracownika] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[STANOWISKO]    Script Date: 24/04/2019 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STANOWISKO](
	[IdStanowiska] [int] IDENTITY(1,1) NOT NULL,
	[NazwaStanowiska] [varchar](60) NULL,
	[Pensja] [decimal](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdStanowiska] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[widok 1]    Script Date: 24/04/2019 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[widok 1]
as SELECT PRACOWNIK.Imie, PRACOWNIK.Nazwisko, STANOWISKO.Pensja, STANOWISKO.NazwaStanowiska
FROM PRACOWNIK INNER JOIN
STANOWISKO ON PRACOWNIK.IdStanowiska = STANOWISKO.IdStanowiska;
GO
/****** Object:  Table [dbo].[KLIENT]    Script Date: 24/04/2019 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KLIENT](
	[IdKlienta] [int] IDENTITY(1,1) NOT NULL,
	[Imie] [varchar](60) NULL,
	[Nazwisko] [varchar](60) NULL,
	[NumerTelefonu] [varchar](60) NULL,
	[Ulica] [varchar](60) NULL,
	[NumerUlica] [varchar](60) NULL,
	[Miasto] [varchar](60) NULL,
	[IdStatusu] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdKlienta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[STATUS_KLIENTA]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STATUS_KLIENTA](
	[IdStatusu] [int] IDENTITY(1,1) NOT NULL,
	[NazwaStatusu] [varchar](60) NULL,
	[ZnizkaProcentowa] [int] NULL,
	[CzyWliczoneSniadania] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdStatusu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[widok2]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[widok2] as
SELECT KLIENT.Imie, KLIENT.Nazwisko, STATUS_KLIENTA.NazwaStatusu, STATUS_KLIENTA.ZnizkaProcentowa, STATUS_KLIENTA.CzyWliczoneSniadania
FROM KLIENT INNER JOIN
STATUS_KLIENTA ON KLIENT.IdStatusu = STATUS_KLIENTA.IdStatusu;
GO
/****** Object:  Table [dbo].[HOTEL]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HOTEL](
	[idHotelu] [int] IDENTITY(1,1) NOT NULL,
	[NumerHotelu] [int] NULL,
	[Ulica] [varchar](60) NULL,
	[NumerUlica] [varchar](60) NULL,
	[Miasto] [varchar](60) NULL,
	[KodPocztowy] [varchar](60) NULL,
	[CzyJestRestauracja] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[idHotelu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[POKOJ]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[POKOJ](
	[IdPokoju] [int] IDENTITY(1,1) NOT NULL,
	[NumerPokoju] [int] NULL,
	[CzyZajety] [bit] NULL,
	[IdKategorii] [int] NULL,
	[CenaPokoju] [decimal](18, 0) NULL,
	[IdHotelu] [int] NULL,
	[LiczbaOsob] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPokoju] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[REZERWACJA]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REZERWACJA](
	[IdRezerwacji] [int] IDENTITY(1,1) NOT NULL,
	[DataRezerwacji] [datetime] NULL,
	[PoczatekPobytu] [datetime] NULL,
	[KoniecPobytu] [datetime] NULL,
	[IdKlienta] [int] NULL,
	[IdPokoju] [int] NULL,
	[ZakonczonyPobyt] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRezerwacji] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[widok3]    Script Date: 24/04/2019 10:37:57 ******/
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
/****** Object:  View [dbo].[widok4]    Script Date: 24/04/2019 10:37:57 ******/
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
/****** Object:  View [dbo].[widok5]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[widok5] as
SELECT K.Nazwisko, COUNT(*) AS LiczbaRezerwacji FROM KLIENT K
INNER JOIN REZERWACJA R ON K.IdKlienta = R.IdKlienta
GROUP BY K.Nazwisko;
GO
/****** Object:  View [dbo].[widok6]    Script Date: 24/04/2019 10:37:57 ******/
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
/****** Object:  Table [dbo].[Audyt]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Audyt](
	[IdAudytu] [int] IDENTITY(1,1) NOT NULL,
	[Tabela] [nchar](50) NULL,
	[IdRekordu] [int] NULL,
	[Zdarzenie] [nchar](50) NULL,
	[DataZdarzenia] [datetime] NULL,
	[Uzytkownik] [nchar](50) NULL,
 CONSTRAINT [PK_Audyt] PRIMARY KEY CLUSTERED 
(
	[IdAudytu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DYZUR]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DYZUR](
	[IdDyzuru] [int] IDENTITY(1,1) NOT NULL,
	[dyzurOd] [datetime] NULL,
	[dyzurDo] [datetime] NULL,
	[IdPracownika] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDyzuru] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KATEGORIA_POKOJU]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KATEGORIA_POKOJU](
	[IdKategorii] [int] IDENTITY(1,1) NOT NULL,
	[CzyJestLazienka] [bit] NULL,
	[CzyJestBalkon] [bit] NULL,
	[NazwaKategorii] [varchar](60) NULL,
	[CzyJestLodowka] [bit] NULL,
	[DwuosoboweLozko] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdKategorii] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[POTRAWA]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[POTRAWA](
	[IdPotrawy] [int] IDENTITY(1,1) NOT NULL,
	[NazwaPotrawy] [varchar](60) NULL,
	[CzyGluten] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPotrawy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RESTAURACJA]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RESTAURACJA](
	[IdRestauracji] [int] IDENTITY(1,1) NOT NULL,
	[GodzinaOtwarcia] [int] NULL,
	[GodzinaZamkniecia] [int] NULL,
	[IdHotelu] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRestauracji] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RESTAURACJA_POTRAWA]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RESTAURACJA_POTRAWA](
	[IdRestauracjaPotrawa] [int] IDENTITY(1,1) NOT NULL,
	[CenaPotrawy] [decimal](18, 0) NULL,
	[IdRestauracji] [int] NULL,
	[IdPotrawy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRestauracjaPotrawa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [index_hotel]    Script Date: 24/04/2019 10:37:57 ******/
CREATE NONCLUSTERED INDEX [index_hotel] ON [dbo].[HOTEL]
(
	[Ulica] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [index_kategoria]    Script Date: 24/04/2019 10:37:57 ******/
CREATE NONCLUSTERED INDEX [index_kategoria] ON [dbo].[KATEGORIA_POKOJU]
(
	[NazwaKategorii] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [index_pokoj]    Script Date: 24/04/2019 10:37:57 ******/
CREATE NONCLUSTERED INDEX [index_pokoj] ON [dbo].[POKOJ]
(
	[IdHotelu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [index_potrawa]    Script Date: 24/04/2019 10:37:57 ******/
CREATE NONCLUSTERED INDEX [index_potrawa] ON [dbo].[POTRAWA]
(
	[CzyGluten] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [index_pracownik]    Script Date: 24/04/2019 10:37:57 ******/
CREATE NONCLUSTERED INDEX [index_pracownik] ON [dbo].[PRACOWNIK]
(
	[Nazwisko] ASC,
	[Imie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [index_restauracja]    Script Date: 24/04/2019 10:37:57 ******/
CREATE NONCLUSTERED INDEX [index_restauracja] ON [dbo].[RESTAURACJA]
(
	[IdHotelu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DYZUR]  WITH CHECK ADD  CONSTRAINT [IdPracownika] FOREIGN KEY([IdPracownika])
REFERENCES [dbo].[PRACOWNIK] ([IdPracownika])
GO
ALTER TABLE [dbo].[DYZUR] CHECK CONSTRAINT [IdPracownika]
GO
ALTER TABLE [dbo].[KLIENT]  WITH CHECK ADD  CONSTRAINT [IdStatusu] FOREIGN KEY([IdStatusu])
REFERENCES [dbo].[STATUS_KLIENTA] ([IdStatusu])
GO
ALTER TABLE [dbo].[KLIENT] CHECK CONSTRAINT [IdStatusu]
GO
ALTER TABLE [dbo].[POKOJ]  WITH CHECK ADD  CONSTRAINT [IdHotelu3] FOREIGN KEY([IdHotelu])
REFERENCES [dbo].[HOTEL] ([idHotelu])
GO
ALTER TABLE [dbo].[POKOJ] CHECK CONSTRAINT [IdHotelu3]
GO
ALTER TABLE [dbo].[POKOJ]  WITH CHECK ADD  CONSTRAINT [IdKategorii] FOREIGN KEY([IdKategorii])
REFERENCES [dbo].[KATEGORIA_POKOJU] ([IdKategorii])
GO
ALTER TABLE [dbo].[POKOJ] CHECK CONSTRAINT [IdKategorii]
GO
ALTER TABLE [dbo].[PRACOWNIK]  WITH CHECK ADD  CONSTRAINT [IdHotelu] FOREIGN KEY([IdHotelu])
REFERENCES [dbo].[HOTEL] ([idHotelu])
GO
ALTER TABLE [dbo].[PRACOWNIK] CHECK CONSTRAINT [IdHotelu]
GO
ALTER TABLE [dbo].[PRACOWNIK]  WITH CHECK ADD  CONSTRAINT [IdStanowiska] FOREIGN KEY([IdStanowiska])
REFERENCES [dbo].[STANOWISKO] ([IdStanowiska])
GO
ALTER TABLE [dbo].[PRACOWNIK] CHECK CONSTRAINT [IdStanowiska]
GO
ALTER TABLE [dbo].[RESTAURACJA]  WITH CHECK ADD  CONSTRAINT [IdHotelu2] FOREIGN KEY([IdHotelu])
REFERENCES [dbo].[HOTEL] ([idHotelu])
GO
ALTER TABLE [dbo].[RESTAURACJA] CHECK CONSTRAINT [IdHotelu2]
GO
ALTER TABLE [dbo].[RESTAURACJA_POTRAWA]  WITH CHECK ADD  CONSTRAINT [IdPotrawy] FOREIGN KEY([IdPotrawy])
REFERENCES [dbo].[POTRAWA] ([IdPotrawy])
GO
ALTER TABLE [dbo].[RESTAURACJA_POTRAWA] CHECK CONSTRAINT [IdPotrawy]
GO
ALTER TABLE [dbo].[RESTAURACJA_POTRAWA]  WITH CHECK ADD  CONSTRAINT [IdRestauracji1] FOREIGN KEY([IdRestauracji])
REFERENCES [dbo].[RESTAURACJA] ([IdRestauracji])
GO
ALTER TABLE [dbo].[RESTAURACJA_POTRAWA] CHECK CONSTRAINT [IdRestauracji1]
GO
ALTER TABLE [dbo].[REZERWACJA]  WITH CHECK ADD  CONSTRAINT [IdKlienta2] FOREIGN KEY([IdKlienta])
REFERENCES [dbo].[KLIENT] ([IdKlienta])
GO
ALTER TABLE [dbo].[REZERWACJA] CHECK CONSTRAINT [IdKlienta2]
GO
ALTER TABLE [dbo].[REZERWACJA]  WITH CHECK ADD  CONSTRAINT [IdPokoju2] FOREIGN KEY([IdPokoju])
REFERENCES [dbo].[POKOJ] ([IdPokoju])
GO
ALTER TABLE [dbo].[REZERWACJA] CHECK CONSTRAINT [IdPokoju2]
GO
/****** Object:  StoredProcedure [dbo].[Procedura1]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Procedura1](@miasto varchar(60), @stara varchar(60), @nowa varchar(60))
as begin

update KLIENT
set Ulica = @nowa
where Miasto = @miasto and Ulica = @stara

update HOTEL
set Ulica = @nowa
where Miasto = @miasto and Ulica = @stara

end
GO
/****** Object:  StoredProcedure [dbo].[Procedura2]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Procedura2] (@potrawa varchar(60), @nowaCena int)
as begin
update RESTAURACJA_POTRAWA
set CenaPotrawy = @nowaCena
where IdPotrawy = (select IdPotrawy from Potrawa where NazwaPotrawy=@potrawa)

end
GO
/****** Object:  StoredProcedure [dbo].[Procedura3]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Procedura3] 
AS
BEGIN
	SET NOCOUNT ON;
	Update REZERWACJA
	Set ZakonczonyPobyt = 'tak'
	WHERE KoniecPobytu < getdate()

	Update REZERWACJA
	Set ZakonczonyPobyt = 'nie'
	WHERE KoniecPobytu > getdate()
END
GO
/****** Object:  StoredProcedure [dbo].[Procedura4]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Procedura4]
@IdRezerwacji int,
@IleSkracamy int
AS
declare
@x int
BEGIN
	SET NOCOUNT ON;
	Update REZERWACJA
	Set KoniecPobytu = DATEADD(DD,-@ileSkracamy,KoniecPobytu)
	WHERE IdRezerwacji = @IdRezerwacji
END
GO
/****** Object:  StoredProcedure [dbo].[Procedura5]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Procedura5] 
@IdHotelu int,
@IdKategorii int,
@nowaCena int
AS
BEGIN
	SET NOCOUNT ON;
	Update POKOJ
	Set CenaPokoju = @nowaCena
	WHERE IdKategorii = @IdKategorii and IdHotelu = @IdHotelu
END
GO
/****** Object:  Trigger [dbo].[Audit_Dyzur]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Audit_Dyzur]
   ON  [dbo].[DYZUR] 
   for DELETE, INSERT
   as
begin
IF EXISTS(SELECT * FROM Deleted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Dyzur', IdDyzuru, 'Delete', GETDATE(), SUSER_NAME()
from deleted

IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Dyzur', IdDyzuru, 'Insert', GETDATE(), SUSER_NAME()
from inserted
end

update DYZUR set IdPracownika = 4 where IdDyzuru = 4

delete from audyt 
GO
ALTER TABLE [dbo].[DYZUR] ENABLE TRIGGER [Audit_Dyzur]
GO
/****** Object:  Trigger [dbo].[Audit_Dyzur_Update]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Audit_Dyzur_Update]
   ON  [dbo].[DYZUR] 
   for update
   as
begin
IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Dyzur', IdDyzuru, 'Update', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[DYZUR] ENABLE TRIGGER [Audit_Dyzur_Update]
GO
/****** Object:  Trigger [dbo].[Audit_Hotel]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[Audit_Hotel]
   ON  [dbo].[HOTEL] 
   for DELETE, INSERT
   as
begin
IF EXISTS(SELECT * FROM Deleted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Hotel', IdHotelu, 'Delete', GETDATE(), SUSER_NAME()
from deleted

IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Hotel', IdHotelu, 'Insert', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[HOTEL] ENABLE TRIGGER [Audit_Hotel]
GO
/****** Object:  Trigger [dbo].[Audit_Hotel_Update]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[Audit_Hotel_Update]
   ON  [dbo].[HOTEL] 
   for update
   as
begin
IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Hotel', IdHotelu, 'Update', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[HOTEL] ENABLE TRIGGER [Audit_Hotel_Update]
GO
/****** Object:  Trigger [dbo].[Audit_Kategoria]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[Audit_Kategoria]
   ON  [dbo].[KATEGORIA_POKOJU] 
   for DELETE, INSERT
   as
begin
IF EXISTS(SELECT * FROM Deleted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Kategoria_Pokoju', IdKategorii, 'Delete', GETDATE(), SUSER_NAME()
from deleted

IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Kategoria_Pokoju', IdKategorii, 'Insert', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[KATEGORIA_POKOJU] ENABLE TRIGGER [Audit_Kategoria]
GO
/****** Object:  Trigger [dbo].[Audit_Kategoria_Update]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create TRIGGER [dbo].[Audit_Kategoria_Update]
   ON  [dbo].[KATEGORIA_POKOJU] 
   for update
   as
begin
IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Kategoria_Pokoju', IdKategorii, 'Update', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[KATEGORIA_POKOJU] ENABLE TRIGGER [Audit_Kategoria_Update]
GO
/****** Object:  Trigger [dbo].[Audit_Klient]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[Audit_Klient]
   ON  [dbo].[KLIENT] 
   for DELETE, INSERT
   as
begin
IF EXISTS(SELECT * FROM Deleted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Klient', IdKlienta, 'Delete', GETDATE(), SUSER_NAME()
from deleted

IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Klient', IdKlienta, 'Insert', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[KLIENT] ENABLE TRIGGER [Audit_Klient]
GO
/****** Object:  Trigger [dbo].[Audit_Klient_Update]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[Audit_Klient_Update]
   ON  [dbo].[KLIENT] 
   for update
   as
begin
IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Klient', IdKlienta, 'Update', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[KLIENT] ENABLE TRIGGER [Audit_Klient_Update]
GO
/****** Object:  Trigger [dbo].[Audit_Pokoj]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[Audit_Pokoj]
   ON  [dbo].[POKOJ] 
   for DELETE, INSERT
   as
begin
IF EXISTS(SELECT * FROM Deleted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Pokoj', IdPokoju, 'Delete', GETDATE(), SUSER_NAME()
from deleted

IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Pokoj', IdPokoju, 'Insert', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[POKOJ] ENABLE TRIGGER [Audit_Pokoj]
GO
/****** Object:  Trigger [dbo].[Audit_Pokoj_Update]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[Audit_Pokoj_Update]
   ON  [dbo].[POKOJ] 
   for update
   as
begin
IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Pokoj', IdPokoju, 'Update', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[POKOJ] ENABLE TRIGGER [Audit_Pokoj_Update]
GO
/****** Object:  Trigger [dbo].[Audit_potrawa]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[Audit_potrawa]
   ON  [dbo].[POTRAWA] 
   for DELETE, INSERT
   as
begin
IF EXISTS(SELECT * FROM Deleted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Potrawa', IdPotrawy, 'Delete', GETDATE(), SUSER_NAME()
from deleted

IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Potrawa', IdPotrawy, 'Insert', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[POTRAWA] ENABLE TRIGGER [Audit_potrawa]
GO
/****** Object:  Trigger [dbo].[Audit_potrawa_Update]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[Audit_potrawa_Update]
   ON  [dbo].[POTRAWA] 
   for update
   as
begin
IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Potrawa', IdPotrawy, 'Update', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[POTRAWA] ENABLE TRIGGER [Audit_potrawa_Update]
GO
/****** Object:  Trigger [dbo].[Audit_Pracownik]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[Audit_Pracownik]
   ON  [dbo].[PRACOWNIK] 
   for DELETE, INSERT
   as
begin
IF EXISTS(SELECT * FROM Deleted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Pracownik', IdPracownika, 'Delete', GETDATE(), SUSER_NAME()
from deleted

IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Pracownik', IdPracownika, 'Insert', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[PRACOWNIK] ENABLE TRIGGER [Audit_Pracownik]
GO
/****** Object:  Trigger [dbo].[Audit_Pracownik_Update]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[Audit_Pracownik_Update]
   ON  [dbo].[PRACOWNIK] 
   for update
   as
begin
IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Pracownik', IdPracownika, 'Update', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[PRACOWNIK] ENABLE TRIGGER [Audit_Pracownik_Update]
GO
/****** Object:  Trigger [dbo].[Audit_Restauracja]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[Audit_Restauracja]
   ON  [dbo].[RESTAURACJA] 
   for DELETE, INSERT
   as
begin
IF EXISTS(SELECT * FROM Deleted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Restauracja', IdRestauracji, 'Delete', GETDATE(), SUSER_NAME()
from deleted

IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Restauracja', IdRestauracji, 'Insert', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[RESTAURACJA] ENABLE TRIGGER [Audit_Restauracja]
GO
/****** Object:  Trigger [dbo].[Audit_Restauracja_Update]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[Audit_Restauracja_Update]
   ON  [dbo].[RESTAURACJA] 
   for update
   as
begin
IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Restauracja', IdRestauracji, 'Update', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[RESTAURACJA] ENABLE TRIGGER [Audit_Restauracja_Update]
GO
/****** Object:  Trigger [dbo].[Audit_Restauracja_Potrawa]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[Audit_Restauracja_Potrawa]
   ON  [dbo].[RESTAURACJA_POTRAWA] 
   for DELETE, INSERT
   as
begin
IF EXISTS(SELECT * FROM Deleted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Restauracja_Potrawa', IdRestauracjaPotrawa, 'Delete', GETDATE(), SUSER_NAME()
from deleted

IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Restauracja_Potrawa', IdRestauracjaPotrawa, 'Insert', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[RESTAURACJA_POTRAWA] ENABLE TRIGGER [Audit_Restauracja_Potrawa]
GO
/****** Object:  Trigger [dbo].[Audit_Restauracja_Potrawa_Update]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[Audit_Restauracja_Potrawa_Update]
   ON  [dbo].[RESTAURACJA_POTRAWA] 
   for update
   as
begin
IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Restauracja_Potrawa', IdRestauracjaPotrawa, 'Update', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[RESTAURACJA_POTRAWA] ENABLE TRIGGER [Audit_Restauracja_Potrawa_Update]
GO
/****** Object:  Trigger [dbo].[Audit_Rezerwacja]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[Audit_Rezerwacja]
   ON  [dbo].[REZERWACJA] 
   for DELETE, INSERT
   as
begin
IF EXISTS(SELECT * FROM Deleted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Rezerwacja', IdRezerwacji, 'Delete', GETDATE(), SUSER_NAME()
from deleted

IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Rezerwacja', IdRezerwacji, 'Insert', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[REZERWACJA] ENABLE TRIGGER [Audit_Rezerwacja]
GO
/****** Object:  Trigger [dbo].[Audit_Rezerwacja_Update]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[Audit_Rezerwacja_Update]
   ON  [dbo].[REZERWACJA] 
   for update
   as
begin
IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Rezerwacja', IdRezerwacji, 'Update', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[REZERWACJA] ENABLE TRIGGER [Audit_Rezerwacja_Update]
GO
/****** Object:  Trigger [dbo].[Audit_Stanowisko]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[Audit_Stanowisko]
   ON  [dbo].[STANOWISKO] 
   for DELETE, INSERT
   as
begin
IF EXISTS(SELECT * FROM Deleted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Stanowisko', IdStanowiska, 'Delete', GETDATE(), SUSER_NAME()
from deleted

IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Stanowisko', IdStanowiska, 'Insert', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[STANOWISKO] ENABLE TRIGGER [Audit_Stanowisko]
GO
/****** Object:  Trigger [dbo].[Audit_Stanowisko_Update]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[Audit_Stanowisko_Update]
   ON  [dbo].[STANOWISKO] 
   for update
   as
begin
IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Stanowisko', IdStanowiska, 'Update', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[STANOWISKO] ENABLE TRIGGER [Audit_Stanowisko_Update]
GO
/****** Object:  Trigger [dbo].[Audit_Status_Klienta]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[Audit_Status_Klienta]
   ON  [dbo].[STATUS_KLIENTA] 
   for DELETE, INSERT
   as
begin
IF EXISTS(SELECT * FROM Deleted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Status_Klienta', IdStatusu, 'Delete', GETDATE(), SUSER_NAME()
from deleted

IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Status_Klienta', IdStatusu, 'Insert', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[STATUS_KLIENTA] ENABLE TRIGGER [Audit_Status_Klienta]
GO
/****** Object:  Trigger [dbo].[Audit_Status_Klienta_Update]    Script Date: 24/04/2019 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[Audit_Status_Klienta_Update]
   ON  [dbo].[STATUS_KLIENTA] 
   for update
   as
begin
IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Status_Klienta', IdStatusu, 'Update', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[STATUS_KLIENTA] ENABLE TRIGGER [Audit_Status_Klienta_Update]
GO
