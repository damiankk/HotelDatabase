USE [Grupa_2]
GO
/****** Object:  Table [dbo].[STANOWISKO]    Script Date: 22/05/2019 19:02:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Trigger [dbo].[Audit_Stanowisko]    Script Date: 22/05/2019 19:02:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[Audit_Stanowisko]
   ON  [dbo].[STANOWISKO] 
   for DELETE, INSERT
   as
begin
IF EXISTS(SELECT * FROM Deleted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Stanowisko', IdStanowiska, 'Delete', GETDATE(), SUSER_NAME()
from deleted

IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Stanowisko', IdStanowiska, 'Insert', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[STANOWISKO] ENABLE TRIGGER [Audit_Stanowisko]
GO
/****** Object:  Trigger [dbo].[Audit_Stanowisko_Update]    Script Date: 22/05/2019 19:02:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[Audit_Stanowisko_Update]
   ON  [dbo].[STANOWISKO] 
   for update
   as
begin
IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Stanowisko', IdStanowiska, 'Update', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[STANOWISKO] ENABLE TRIGGER [Audit_Stanowisko_Update]
GO
