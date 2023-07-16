CREATE VIEW [dbo].[V_Game]
	AS 
	SELECT [Game_Id],[Name],[Publisher_Id], [Price],[Resume], [Release_Date] FROM [Game]
	WHERE [Is_Active] = 1
