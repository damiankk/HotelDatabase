USE [master]
GO
/****** Object:  Database [Grupa_2]    Script Date: 11.04.2019 15:33:39 ******/
CREATE DATABASE [Grupa_2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Grupa_2', FILENAME = N'F:\Data\Grupa_2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Grupa_2_log', FILENAME = N'F:\Log\Grupa_2_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Grupa_2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Grupa_2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Grupa_2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Grupa_2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Grupa_2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Grupa_2] SET ARITHABORT OFF 
GO
ALTER DATABASE [Grupa_2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Grupa_2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Grupa_2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Grupa_2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Grupa_2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Grupa_2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Grupa_2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Grupa_2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Grupa_2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Grupa_2] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Grupa_2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Grupa_2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Grupa_2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Grupa_2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Grupa_2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Grupa_2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Grupa_2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Grupa_2] SET RECOVERY FULL 
GO
ALTER DATABASE [Grupa_2] SET  MULTI_USER 
GO
ALTER DATABASE [Grupa_2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Grupa_2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Grupa_2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Grupa_2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Grupa_2] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Grupa_2', N'ON'
GO
USE [Grupa_2]
GO
/****** Object:  User [mwesolowski]    Script Date: 11.04.2019 15:33:39 ******/
CREATE USER [mwesolowski] FOR LOGIN [mwesolowski] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [llaszuk]    Script Date: 11.04.2019 15:33:39 ******/
CREATE USER [llaszuk] FOR LOGIN [llaszuk] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [dkonopka]    Script Date: 11.04.2019 15:33:39 ******/
CREATE USER [dkonopka] FOR LOGIN [dkonopka] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [mwesolowski]
GO
ALTER ROLE [db_datareader] ADD MEMBER [mwesolowski]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [mwesolowski]
GO
ALTER ROLE [db_owner] ADD MEMBER [llaszuk]
GO
ALTER ROLE [db_datareader] ADD MEMBER [llaszuk]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [llaszuk]
GO
ALTER ROLE [db_owner] ADD MEMBER [dkonopka]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [dkonopka]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [dkonopka]
GO
ALTER ROLE [db_datareader] ADD MEMBER [dkonopka]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [dkonopka]
GO
/****** Object:  UserDefinedFunction [dbo].[funkcja1]    Script Date: 11.04.2019 15:33:40 ******/
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
/****** Object:  UserDefinedFunction [dbo].[funkcja2]    Script Date: 11.04.2019 15:33:40 ******/
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
/****** Object:  UserDefinedFunction [dbo].[funkcja3]    Script Date: 11.04.2019 15:33:40 ******/
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
/****** Object:  UserDefinedFunction [dbo].[funkcja4]    Script Date: 11.04.2019 15:33:40 ******/
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
/****** Object:  UserDefinedFunction [dbo].[funkcja5]    Script Date: 11.04.2019 15:33:40 ******/
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
/****** Object:  Table [dbo].[Audyt]    Script Date: 11.04.2019 15:33:40 ******/
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
/****** Object:  Table [dbo].[DYZUR]    Script Date: 11.04.2019 15:33:40 ******/
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
/****** Object:  Table [dbo].[HOTEL]    Script Date: 11.04.2019 15:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KATEGORIA_POKOJU]    Script Date: 11.04.2019 15:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KLIENT]    Script Date: 11.04.2019 15:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[POKOJ]    Script Date: 11.04.2019 15:33:40 ******/
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
/****** Object:  Table [dbo].[POTRAWA]    Script Date: 11.04.2019 15:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PRACOWNIK]    Script Date: 11.04.2019 15:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RESTAURACJA]    Script Date: 11.04.2019 15:33:40 ******/
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
/****** Object:  Table [dbo].[RESTAURACJA_POTRAWA]    Script Date: 11.04.2019 15:33:40 ******/
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
/****** Object:  Table [dbo].[REZERWACJA]    Script Date: 11.04.2019 15:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[STANOWISKO]    Script Date: 11.04.2019 15:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[STATUS_KLIENTA]    Script Date: 11.04.2019 15:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[widok 1]    Script Date: 11.04.2019 15:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[widok 1]
as SELECT PRACOWNIK.Imie, PRACOWNIK.Nazwisko, STANOWISKO.Pensja, STANOWISKO.NazwaStanowiska
FROM PRACOWNIK INNER JOIN
STANOWISKO ON PRACOWNIK.IdStanowiska = STANOWISKO.IdStanowiska;
GO
/****** Object:  View [dbo].[widok2]    Script Date: 11.04.2019 15:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[widok2] as
SELECT KLIENT.Imie, KLIENT.Nazwisko, STATUS_KLIENTA.NazwaStatusu, STATUS_KLIENTA.ZnizkaProcentowa, STATUS_KLIENTA.CzyWliczoneSniadania
FROM KLIENT INNER JOIN
STATUS_KLIENTA ON KLIENT.IdStatusu = STATUS_KLIENTA.IdStatusu;
GO
/****** Object:  View [dbo].[widok3]    Script Date: 11.04.2019 15:33:40 ******/
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
/****** Object:  View [dbo].[widok4]    Script Date: 11.04.2019 15:33:40 ******/
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
/****** Object:  View [dbo].[widok5]    Script Date: 11.04.2019 15:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[widok5] as
SELECT K.Nazwisko, COUNT(*) AS LiczbaRezerwacji FROM KLIENT K
INNER JOIN REZERWACJA R ON K.IdKlienta = R.IdKlienta
GROUP BY K.Nazwisko;
GO
/****** Object:  View [dbo].[widok6]    Script Date: 11.04.2019 15:33:40 ******/
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
/****** Object:  Index [index_dyzur]    Script Date: 11.04.2019 15:33:40 ******/
CREATE NONCLUSTERED INDEX [index_dyzur] ON [dbo].[DYZUR]
(
	[IdPracownika] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [index_klient]    Script Date: 11.04.2019 15:33:40 ******/
CREATE NONCLUSTERED INDEX [index_klient] ON [dbo].[KLIENT]
(
	[Imie] ASC,
	[Nazwisko] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [index_pracownik]    Script Date: 11.04.2019 15:33:40 ******/
CREATE NONCLUSTERED INDEX [index_pracownik] ON [dbo].[PRACOWNIK]
(
	[Imie] ASC,
	[Nazwisko] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [index_rezerwacja]    Script Date: 11.04.2019 15:33:40 ******/
CREATE NONCLUSTERED INDEX [index_rezerwacja] ON [dbo].[REZERWACJA]
(
	[IdKlienta] ASC,
	[IdPokoju] ASC
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
/****** Object:  StoredProcedure [dbo].[Procedura1]    Script Date: 11.04.2019 15:33:40 ******/
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
/****** Object:  StoredProcedure [dbo].[Procedura2]    Script Date: 11.04.2019 15:33:40 ******/
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
/****** Object:  StoredProcedure [dbo].[Procedura3]    Script Date: 11.04.2019 15:33:40 ******/
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
/****** Object:  StoredProcedure [dbo].[Procedura4]    Script Date: 11.04.2019 15:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Procedura4]
@IdRezerwacji int,
@IleSkracamy int
AS
BEGIN
	SET NOCOUNT ON;
	Update REZERWACJA
	Set KoniecPobytu = Day(KoniecPobytu) - Day(@IleSkracamy)
	WHERE IdRezerwacji = @IdRezerwacji
END

GO
/****** Object:  StoredProcedure [dbo].[Procedura5]    Script Date: 11.04.2019 15:33:40 ******/
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
USE [master]
GO
ALTER DATABASE [Grupa_2] SET  READ_WRITE 
GO
