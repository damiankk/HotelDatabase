USE [Grupa_2]
GO
/****** Object:  Table [dbo].[RESTAURACJA_POTRAWA]    Script Date: 22/05/2019 19:02:48 ******/
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
/****** Object:  Trigger [dbo].[Audit_Restauracja_Potrawa]    Script Date: 22/05/2019 19:02:50 ******/
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
/****** Object:  Trigger [dbo].[Audit_Restauracja_Potrawa_Update]    Script Date: 22/05/2019 19:02:50 ******/
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
