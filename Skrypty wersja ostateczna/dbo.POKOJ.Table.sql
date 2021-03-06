USE [Grupa_2]
GO
/****** Object:  Table [dbo].[POKOJ]    Script Date: 22/05/2019 19:02:47 ******/
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
/****** Object:  Index [index_pokoj]    Script Date: 22/05/2019 19:02:48 ******/
CREATE NONCLUSTERED INDEX [index_pokoj] ON [dbo].[POKOJ]
(
	[IdHotelu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
/****** Object:  Trigger [dbo].[Audit_Pokoj]    Script Date: 22/05/2019 19:02:49 ******/
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
/****** Object:  Trigger [dbo].[Audit_Pokoj_Update]    Script Date: 22/05/2019 19:02:49 ******/
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
