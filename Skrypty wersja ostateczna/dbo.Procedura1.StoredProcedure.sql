USE [Grupa_2]
GO
/****** Object:  StoredProcedure [dbo].[Procedura1]    Script Date: 22/05/2019 19:02:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Procedura1](@miasto varchar(60), @stara varchar(60), @nowa varchar(60))
as begin

update KLIENT
set Ulica = @nowa
where Miasto = @miasto and Ulica = @stara

update HOTEL
set Ulica = @nowa
where Miasto = @miasto and Ulica = @stara

end
GO
