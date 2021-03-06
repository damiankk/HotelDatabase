USE [Grupa_2]
GO
/****** Object:  Table [dbo].[KLIENT]    Script Date: 22/05/2019 19:02:47 ******/
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
ALTER TABLE [dbo].[KLIENT]  WITH CHECK ADD  CONSTRAINT [IdStatusu] FOREIGN KEY([IdStatusu])
REFERENCES [dbo].[STATUS_KLIENTA] ([IdStatusu])
GO
ALTER TABLE [dbo].[KLIENT] CHECK CONSTRAINT [IdStatusu]
GO
/****** Object:  Trigger [dbo].[Audit_Klient]    Script Date: 22/05/2019 19:02:49 ******/
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
/****** Object:  Trigger [dbo].[Audit_Klient_Update]    Script Date: 22/05/2019 19:02:49 ******/
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
