USE [Grupa_2]
GO
/****** Object:  Table [dbo].[DYZUR]    Script Date: 22/05/2019 19:02:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DYZUR](
	[IdDyzuru] [int] IDENTITY(1,1) NOT NULL,
	[dyzurOd] [datetime] NULL,
	[dyzurDo] [datetime] NULL,
	[IdPracownika] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDyzuru] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DYZUR]  WITH CHECK ADD  CONSTRAINT [IdPracownika] FOREIGN KEY([IdPracownika])
REFERENCES [dbo].[PRACOWNIK] ([IdPracownika])
GO
ALTER TABLE [dbo].[DYZUR] CHECK CONSTRAINT [IdPracownika]
GO
/****** Object:  Trigger [dbo].[Audit_Dyzur]    Script Date: 22/05/2019 19:02:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Audit_Dyzur]
   ON  [dbo].[DYZUR] 
   for DELETE, INSERT
   as
begin
IF EXISTS(SELECT * FROM Deleted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Dyzur', IdDyzuru, 'Delete', GETDATE(), SUSER_NAME()
from deleted

IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Dyzur', IdDyzuru, 'Insert', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[DYZUR] ENABLE TRIGGER [Audit_Dyzur]
GO
/****** Object:  Trigger [dbo].[Audit_Dyzur_Update]    Script Date: 22/05/2019 19:02:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Audit_Dyzur_Update]
   ON  [dbo].[DYZUR] 
   for update
   as
begin
IF EXISTS(SELECT * FROM inserted)
insert into Audyt(Tabela, Idrekordu, Zdarzenie, DataZdarzenia, Uzytkownik)
select 'Dyzur', IdDyzuru, 'Update', GETDATE(), SUSER_NAME()
from inserted
end
GO
ALTER TABLE [dbo].[DYZUR] ENABLE TRIGGER [Audit_Dyzur_Update]
GO
