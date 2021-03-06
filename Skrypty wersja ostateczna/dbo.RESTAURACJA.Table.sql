USE [Grupa_2]
GO
/****** Object:  Table [dbo].[RESTAURACJA]    Script Date: 22/05/2019 19:02:48 ******/
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
/****** Object:  Index [index_restauracja]    Script Date: 22/05/2019 19:02:48 ******/
CREATE NONCLUSTERED INDEX [index_restauracja] ON [dbo].[RESTAURACJA]
(
	[IdHotelu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RESTAURACJA]  WITH CHECK ADD  CONSTRAINT [IdHotelu2] FOREIGN KEY([IdHotelu])
REFERENCES [dbo].[HOTEL] ([idHotelu])
GO
ALTER TABLE [dbo].[RESTAURACJA] CHECK CONSTRAINT [IdHotelu2]
GO
/****** Object:  Trigger [dbo].[Audit_Restauracja]    Script Date: 22/05/2019 19:02:50 ******/
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
/****** Object:  Trigger [dbo].[Audit_Restauracja_Update]    Script Date: 22/05/2019 19:02:50 ******/
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
