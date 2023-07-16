CREATE TABLE [dbo].[Game]
(
	[Game_Id] INT NOT NULL IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	[Resume] NVARCHAR(200) NOT NULL,
	[Release_Date] DATE NOT NULL,
	[Is_Active] BIT DEFAULT 1,
	[Price] DECIMAL(15,2) NULL,
	[Publisher_Id] INT NULL,

	CONSTRAINT Pk_Game PRIMARY KEY ([Game_Id]),
	CONSTRAINT Fk_Game__Publisher FOREIGN KEY ([Publisher_Id]) REFERENCES [Publisher]([Publisher_Id])
)
