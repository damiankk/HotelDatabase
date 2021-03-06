USE [Grupa_2]
GO
/****** Object:  Table [dbo].[STATUS_KLIENTA]    Script Date: 22/05/2019 19:02:47 ******/
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
/****** Object:  Trigger [dbo].[Audit_Status_Klienta]    Script Date: 22/05/2019 19:02:50 ******/
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
/****** Object:  Trigger [dbo].[Audit_Status_Klienta_Update]    Script Date: 22/05/2019 19:02:50 ******/
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
