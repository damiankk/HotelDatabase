USE [Grupa_2]
GO
/****** Object:  Table [dbo].[REZERWACJA]    Script Date: 22/05/2019 19:02:47 ******/
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
/****** Object:  Trigger [dbo].[Audit_Rezerwacja]    Script Date: 22/05/2019 19:02:50 ******/
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
/****** Object:  Trigger [dbo].[Audit_Rezerwacja_Update]    Script Date: 22/05/2019 19:02:50 ******/
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
