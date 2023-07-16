CREATE TABLE [dbo].[Genre]
(
	[Genre_Id] INT NOT NULL IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	[Description] NVARCHAR(200) NOT NULL,

	CONSTRAINT Pk_Genre PRIMARY KEY ([Genre_Id]),
	CONSTRAINT Uk_Genre__Name UNIQUE ([Name])
)
