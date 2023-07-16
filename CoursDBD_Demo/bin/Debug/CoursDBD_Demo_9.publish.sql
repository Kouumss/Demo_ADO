/*
Script de déploiement pour Demo_ADO

Ce code a été généré par un outil.
La modification de ce fichier peut provoquer un comportement incorrect et sera perdue si
le code est régénéré.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Demo_ADO"
:setvar DefaultFilePrefix "Demo_ADO"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\"

GO
:on error exit
GO
/*
Détectez le mode SQLCMD et désactivez l'exécution du script si le mode SQLCMD n'est pas pris en charge.
Pour réactiver le script une fois le mode SQLCMD activé, exécutez ce qui suit :
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Le mode SQLCMD doit être activé de manière à pouvoir exécuter ce script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Création de la base de données $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Création de Table [dbo].[Game]...';


GO
CREATE TABLE [dbo].[Game] (
    [Game_Id]      INT             IDENTITY (1, 1) NOT NULL,
    [Name]         NVARCHAR (50)   NOT NULL,
    [Resume]       NVARCHAR (200)  NOT NULL,
    [Release_Date] DATE            NOT NULL,
    [Is_Active]    BIT             NULL,
    [Price]        DECIMAL (15, 2) NULL,
    [Publisher_Id] INT             NULL,
    CONSTRAINT [Pk_Game] PRIMARY KEY CLUSTERED ([Game_Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[Game_Genre]...';


GO
CREATE TABLE [dbo].[Game_Genre] (
    [Game_Id]  INT NOT NULL,
    [Genre_Id] INT NOT NULL,
    CONSTRAINT [Pk_Game_Genre] PRIMARY KEY CLUSTERED ([Game_Id] ASC, [Genre_Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[Genre]...';


GO
CREATE TABLE [dbo].[Genre] (
    [Genre_Id]    INT            IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (50)  NOT NULL,
    [Description] NVARCHAR (200) NOT NULL,
    CONSTRAINT [Pk_Genre] PRIMARY KEY CLUSTERED ([Genre_Id] ASC),
    CONSTRAINT [Uk_Genre__Name] UNIQUE NONCLUSTERED ([Name] ASC)
);


GO
PRINT N'Création de Table [dbo].[Publisher]...';


GO
CREATE TABLE [dbo].[Publisher] (
    [Publisher_Id]  INT           IDENTITY (1, 1) NOT NULL,
    [Name]          NVARCHAR (50) NOT NULL,
    [Country]       NVARCHAR (50) NOT NULL,
    [Creation_Date] DATE          NULL,
    CONSTRAINT [Pk_Publisher] PRIMARY KEY CLUSTERED ([Publisher_Id] ASC),
    CONSTRAINT [Uk_Publisher__Name_Country] UNIQUE NONCLUSTERED ([Name] ASC, [Country] ASC)
);


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[Game]...';


GO
ALTER TABLE [dbo].[Game]
    ADD DEFAULT 1 FOR [Is_Active];


GO
PRINT N'Création de Clé étrangère [dbo].[Fk_Game__Publisher]...';


GO
ALTER TABLE [dbo].[Game]
    ADD CONSTRAINT [Fk_Game__Publisher] FOREIGN KEY ([Publisher_Id]) REFERENCES [dbo].[Publisher] ([Publisher_Id]);


GO
PRINT N'Création de Clé étrangère [dbo].[Fk_Game_Genre__Game]...';


GO
ALTER TABLE [dbo].[Game_Genre]
    ADD CONSTRAINT [Fk_Game_Genre__Game] FOREIGN KEY ([Game_Id]) REFERENCES [dbo].[Game] ([Game_Id]);


GO
PRINT N'Création de Clé étrangère [dbo].[Fk_Game_Genre__Genre]...';


GO
ALTER TABLE [dbo].[Game_Genre]
    ADD CONSTRAINT [Fk_Game_Genre__Genre] FOREIGN KEY ([Genre_Id]) REFERENCES [dbo].[Genre] ([Genre_Id]);


GO
PRINT N'Création de Vue [dbo].[V_Game]...';


GO
CREATE VIEW [dbo].[V_Game]
	AS 
	SELECT [Game_Id],[Name],[Publisher_Id], [Price],[Resume], [Release_Date] FROM [Game]
	WHERE [Is_Active] = 1
GO
/*
Modèle de script de post-déploiement							
--------------------------------------------------------------------------------------
 Ce fichier contient des instructions SQL qui seront ajoutées au script de compilation.		
 Utilisez la syntaxe SQLCMD pour inclure un fichier dans le script de post-déploiement.			
 Exemple :      :r .\monfichier.sql								
 Utilisez la syntaxe SQLCMD pour référencer une variable dans le script de post-déploiement.		
 Exemple :      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

--GENRE

SET IDENTITY_INSERT [Genre] ON;  -- ACTIVATION INCREMENTATION MANUEL
GO


INSERT INTO Genre ([Genre_Id],[Name],[Description]) VALUES

(1,'Aventure', 'Pour les plus aventuriers courageux ..'),
(2,'FPS', 'Pour les accros du clic souris ..'),
(3,'Action', 'Pour les amateurs de sensation fortes ..'),
(4,'RPG', 'Pour les amoureux de quêtes et donjons ..'),
(5,'Arcade', 'Pour les ceux qui sortent du commun ..')
GO

SET IDENTITY_INSERT [Genre] OFF; -- DESACT AUTO INCREMENTATION
GO

----------------------------------------------------------------------
--PUBLISHER

SET IDENTITY_INSERT [Publisher] ON; 
GO

INSERT INTO Publisher ([Publisher_Id],[Name],[Country],[Creation_Date])
VALUES 
(1, 'Blizzard', 'Angleterre', '20230517'),
(2, 'Sony', 'France', '20230411'),
(3, 'Playstation', 'Japon', '20230222'),
(4, 'X-box', 'Etas-Unis', '20230606'),
(5, 'Nitendo', 'Chine', '20230216')
GO

SET IDENTITY_INSERT [Publisher] OFF; 
GO

------------------------------------------------------------------------------
--GAME

SET IDENTITY_INSERT [Game] ON; 
GO

INSERT INTO Game ([Game_Id],[Name],[Resume],[Price],[Is_Active],[Release_Date])
VALUES (1, 'Warcraft', 'Contrée du Benchmark',68.99,1,'20230517'),
(2, 'Batman', 'Bienvenu a Gotham City',65.99,1,'20231117'),
(3, 'CallOfDutty', 'Tire sur tous ce qui bouge !',40.99,1,'20230717'),
(4, 'DevilMayCry', 'Affrontez des boss immenses et fort !',60.99,1,'20230817'),
(5, 'StarCraft', 'Démolissez tout avec vos troupes',55.99,1,'20231217'),
(6, 'Burnout', 'Sangoku le SuperSayan',70.99,1,'20230417')
GO

SET IDENTITY_INSERT Game OFF; 
GO
-- ManyToMany - GAME + GENRE

INSERT INTO Game_Genre ([Game_Id],[Genre_Id]) 
VALUES 
(1,2),
(2,3),
(3,2),
(3,4),
(4,3),
(5,4),
(6,5)
GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Mise à jour terminée.';


GO
