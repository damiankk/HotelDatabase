USE [Grupa_2]
GO
/****** Object:  Table [dbo].[KATEGORIA_POKOJU]    Script Date: 22/05/2019 19:02:48 ******/
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
SET ANSI_PADDING ON
GO
/****** Object:  Index [index_kategoria]    Script Date: 22/05/2019 19:02:48 ******/
CREATE NONCLUSTERED INDEX [index_kategoria] ON [dbo].[KATEGORIA_POKOJU]
(
	[NazwaKategorii] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Trigger [dbo].[Audit_Kategoria]    Script Date: 22/05/2019 19:02:49 ******/
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
/****** Object:  Trigger [dbo].[Audit_Kategoria_Update]    Script Date: 22/05/2019 19:02:49 ******/
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
