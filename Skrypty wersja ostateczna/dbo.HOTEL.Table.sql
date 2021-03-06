USE [Grupa_2]
GO
/****** Object:  Table [dbo].[HOTEL]    Script Date: 22/05/2019 19:02:47 ******/
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
SET ANSI_PADDING ON
GO
/****** Object:  Index [index_hotel]    Script Date: 22/05/2019 19:02:48 ******/
CREATE NONCLUSTERED INDEX [index_hotel] ON [dbo].[HOTEL]
(
	[Ulica] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Trigger [dbo].[Audit_Hotel]    Script Date: 22/05/2019 19:02:49 ******/
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
/****** Object:  Trigger [dbo].[Audit_Hotel_Update]    Script Date: 22/05/2019 19:02:49 ******/
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
