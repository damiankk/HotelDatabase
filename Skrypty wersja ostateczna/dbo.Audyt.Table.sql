USE [Grupa_2]
GO
/****** Object:  Table [dbo].[Audyt]    Script Date: 22/05/2019 19:02:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Audyt](
	[IdAudytu] [int] IDENTITY(1,1) NOT NULL,
	[Tabela] [nchar](50) NULL,
	[IdRekordu] [int] NULL,
	[Zdarzenie] [nchar](50) NULL,
	[DataZdarzenia] [datetime] NULL,
	[Uzytkownik] [nchar](50) NULL,
 CONSTRAINT [PK_Audyt] PRIMARY KEY CLUSTERED 
(
	[IdAudytu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
