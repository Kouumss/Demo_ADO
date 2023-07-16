CREATE TABLE [dbo].[Game_Genre]  
(
    --MANY TO MANY PURE 

	[Game_Id] INT NOT NULL ,
	[Genre_Id] INT NOT NULL ,

	CONSTRAINT Pk_Game_Genre PRIMARY KEY ([Game_Id], [Genre_Id]),
	CONSTRAINT Fk_Game_Genre__Game FOREIGN KEY ([Game_Id]) REFERENCES [Game] ([Game_Id]),
	CONSTRAINT Fk_Game_Genre__Genre FOREIGN KEY ([Genre_Id]) REFERENCES [Genre] ([Genre_Id])
)
