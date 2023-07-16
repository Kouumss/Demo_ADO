/*
Script de déploiement pour ADO_DB

Ce code a été généré par un outil.
La modification de ce fichier peut provoquer un comportement incorrect et sera perdue si
le code est régénéré.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "ADO_DB"
:setvar DefaultFilePrefix "ADO_DB"
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
USE [$(DatabaseName)];


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


INSERT INTO Genre ([Genre_Id],[Name], [Description]) VALUES

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
PRINT N'Mise à jour terminée.';


GO
