CREATE TABLE [dbo].[Publisher]
(
	[Publisher_Id] INT NOT NULL IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	[Country] NVARCHAR(50) NOT NULL,
	[Creation_Date] DATE NULL,

	CONSTRAINT Pk_Publisher PRIMARY KEY ([Publisher_Id]),
	CONSTRAINT Uk_Publisher__Name_Country UNIQUE ([Name],[Country])
)
