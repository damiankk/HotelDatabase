USE [Grupa_2]
GO
/****** Object:  Table [dbo].[PRACOWNIK]    Script Date: 22/05/2019 19:02:46 ******/
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
SET ANSI_PADDING ON
GO
/****** Object:  Index [index_pracownik]    Script Date: 22/05/2019 19:02:48 ******/
CREATE NONCLUSTERED INDEX [index_pracownik] ON [dbo].[PRACOWNIK]
(
	[Nazwisko] ASC,
	[Imie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
/****** Object:  Trigger [dbo].[Audit_Pracownik]    Script Date: 22/05/2019 19:02:49 ******/
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
/****** Object:  Trigger [dbo].[Audit_Pracownik_Update]    Script Date: 22/05/2019 19:02:50 ******/
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
