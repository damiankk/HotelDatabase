USE [Grupa_2]
GO
/****** Object:  StoredProcedure [dbo].[Procedura2]    Script Date: 22/05/2019 19:02:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Procedura2] (@potrawa varchar(60), @nowaCena int)
as begin
update RESTAURACJA_POTRAWA
set CenaPotrawy = @nowaCena
where IdPotrawy = (select IdPotrawy from Potrawa where NazwaPotrawy=@potrawa)

end
GO
