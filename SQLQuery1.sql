CREATE DATABASE Marvel;
GO

USE Marvel;
GO


CREATE TRIGGER AutomaticDatabaseCreationTrigger
ON ALL SERVER 
FOR CREATE_DATABASE 
AS 
BEGIN 
    DECLARE @databaseName NVARCHAR(128)
    SET @databaseName = EVENTDATA().value('(/EVENT_INSTANCE/DatabaseName)[1]', 'NVARCHAR(128)')
    
    IF @databaseName = 'Marvel'
    BEGIN
        DECLARE @sql NVARCHAR(MAX)
        SET @sql = '
        USE Marvel;
        CREATE TABLE Origins (
            OriginID INT PRIMARY KEY,
            OriginName NVARCHAR(100) NOT NULL CHECK (LEN(OriginName) > 0)
        );

        CREATE TABLE Characters (
            CharacterID INT PRIMARY KEY,
            Name NVARCHAR(100) NOT NULL CHECK (LEN(Name) > 0),
            Gender NVARCHAR(10),
            Age INT CHECK (Age >= 0),
            OriginID INT FOREIGN KEY REFERENCES Origins(OriginID)
        );

        CREATE TABLE Comics (
            ComicID INT PRIMARY KEY,
            Title NVARCHAR(100) NOT NULL CHECK (LEN(Title) > 0),
            IssueNumber INT CHECK (IssueNumber >= 0),
            PublicationDate DATE
        );

        CREATE TABLE Teams (
            TeamID INT PRIMARY KEY,
            TeamName NVARCHAR(100) NOT NULL CHECK (LEN(TeamName) > 0)
        );

        CREATE TABLE Powers (
            PowerID INT PRIMARY KEY,
            PowerName NVARCHAR(100) NOT NULL CHECK (LEN(PowerName) > 0),
            Description NVARCHAR(MAX)
        );

        CREATE TABLE Events (
            EventID INT PRIMARY KEY,
            EventName NVARCHAR(100) NOT NULL CHECK (LEN(EventName) > 0),
            EventDate DATE
        );

        CREATE TABLE Movies (
            MovieID INT PRIMARY KEY,
            Title NVARCHAR(100) NOT NULL CHECK (LEN(Title) > 0),
            ReleaseDate DATE
        );

        CREATE TABLE Series (
            SeriesID INT PRIMARY KEY,
            Title NVARCHAR(100) NOT NULL CHECK (LEN(Title) > 0),
            StartDate DATE
        );

        CREATE TABLE Creators (
            CreatorID INT PRIMARY KEY,
            Name NVARCHAR(100) NOT NULL CHECK (LEN(Name) > 0)
        );

        CREATE TABLE Relationships (
            RelationshipID INT PRIMARY KEY,
            Character1ID INT,
            Character2ID INT,
            RelationshipType NVARCHAR(50),
            FOREIGN KEY (Character1ID) REFERENCES Characters(CharacterID),
            FOREIGN KEY (Character2ID) REFERENCES Characters(CharacterID)
        );'

        EXEC sp_executesql @sql
    END
END;
GO 

-- Trigger for creating user roles upon database creation
CREATE TRIGGER CreateUserRolesTrigger
ON ALL SERVER 
FOR CREATE_DATABASE 
AS 
BEGIN 
    DECLARE @databaseName NVARCHAR(128)
    SET @databaseName = EVENTDATA().value('(/EVENT_INSTANCE/DatabaseName)[1]', 'NVARCHAR(128)')
    
    IF @databaseName = 'Marvel'
    BEGIN
        DECLARE @sql NVARCHAR(MAX)
        SET @sql = '
        USE Marvel;
        CREATE ROLE Admin;
        CREATE ROLE User;
        ALTER ROLE Admin ADD MEMBER [YourAdminUserNameHere];
        ALTER ROLE User ADD MEMBER [YourRegularUserNameHere];'

        EXEC sp_executesql @sql
    END
END;
GO

-- Trigger for auditing database changes
CREATE TRIGGER AuditDatabaseChangesTrigger
ON ALL SERVER 
FOR CREATE_DATABASE 
AS 
BEGIN 
    DECLARE @databaseName NVARCHAR(128)
    SET @databaseName = EVENTDATA().value('(/EVENT_INSTANCE/DatabaseName)[1]', 'NVARCHAR(128)')
    
    IF @databaseName = 'Marvel'
    BEGIN
        -- Add auditing logic here
        PRINT 'Auditing database creation for Marvel database.'
    END
END;
GO
-- Trigger for creating audit table for database changes
CREATE TRIGGER CreateAuditTableTrigger
ON ALL SERVER 
FOR CREATE_DATABASE 
AS 
BEGIN 
    DECLARE @databaseName NVARCHAR(128)
    SET @databaseName = EVENTDATA().value('(/EVENT_INSTANCE/DatabaseName)[1]', 'NVARCHAR(128)')
    
    IF @databaseName = 'Marvel'
    BEGIN
        DECLARE @sql NVARCHAR(MAX)
        SET @sql = '
        USE Marvel;
        CREATE TABLE AuditTrail (
            AuditID INT PRIMARY KEY IDENTITY(1,1),
            EventType NVARCHAR(100),
            EventDate DATETIME,
            UserName NVARCHAR(100),
            ObjectName NVARCHAR(100),
            SQLText NVARCHAR(MAX)
        );'

        EXEC sp_executesql @sql
    END
END;
GO

-- Trigger for setting default permissions for the newly created database
CREATE TRIGGER SetDefaultPermissionsTrigger
ON ALL SERVER 
FOR CREATE_DATABASE 
AS 
BEGIN 
    DECLARE @databaseName NVARCHAR(128)
    SET @databaseName = EVENTDATA().value('(/EVENT_INSTANCE/DatabaseName)[1]', 'NVARCHAR(128)')
    
    IF @databaseName = 'Marvel'
    BEGIN
        DECLARE @sql NVARCHAR(MAX)
        SET @sql = '
        USE Marvel;
        GRANT SELECT, INSERT, UPDATE, DELETE ON DATABASE::Marvel TO [YourRegularUserNameHere];
        GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::dbo TO [YourRegularUserNameHere];
        GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::dbo TO [YourAdminUserNameHere];'

        EXEC sp_executesql @sql
    END
END;
GO

-- Trigger for creating basic indexes for the newly created database
CREATE TRIGGER CreateBasicIndexesTrigger
ON ALL SERVER 
FOR CREATE_DATABASE 
AS 
BEGIN 
    DECLARE @databaseName NVARCHAR(128)
    SET @databaseName = EVENTDATA().value('(/EVENT_INSTANCE/DatabaseName)[1]', 'NVARCHAR(128)')
    
    IF @databaseName = 'Marvel'
    BEGIN
        DECLARE @sql NVARCHAR(MAX)
        SET @sql = '
        USE Marvel;
        CREATE INDEX IX_Characters_Name ON Characters(Name);
        CREATE INDEX IX_Events_EventDate ON Events(EventDate);
        CREATE INDEX IX_Movies_ReleaseDate ON Movies(ReleaseDate);'

        EXEC sp_executesql @sql
    END
END;
GO

-- Trigger for creating database backups for the newly created database
CREATE TRIGGER CreateDatabaseBackupsTrigger
ON ALL SERVER 
FOR CREATE_DATABASE 
AS 
BEGIN 
    DECLARE @databaseName NVARCHAR(128)
    SET @databaseName = EVENTDATA().value('(/EVENT_INSTANCE/DatabaseName)[1]', 'NVARCHAR(128)')
    
    IF @databaseName = 'Marvel'
    BEGIN
        DECLARE @sql NVARCHAR(MAX)
        SET @sql = '
        USE master;
        BACKUP DATABASE Marvel TO DISK = ''C:\Backups\Marvel_backup.bak'';'

        EXEC sp_executesql @sql
    END
END;
GO

-- Trigger for setting maintenance plan for the newly created database
CREATE TRIGGER SetMaintenancePlanTrigger
ON ALL SERVER 
FOR CREATE_DATABASE 
AS 
BEGIN 
    DECLARE @databaseName NVARCHAR(128)
    SET @databaseName = EVENTDATA().value('(/EVENT_INSTANCE/DatabaseName)[1]', 'NVARCHAR(128)')
    
    IF @databaseName = 'Marvel'
    BEGIN
        EXEC msdb.dbo.sp_add_maintenance_plan @plan_name = N'MaintenancePlan_' + @databaseName,
                                               @plan_id = N'NULL',
                                               @begin_date = GETDATE(),
                                               @enabled = 1;
    END
END;
GO

-- Trigger for creating notification events for the newly created database
CREATE TRIGGER CreateNotificationEventsTrigger
ON ALL SERVER 
FOR CREATE_DATABASE 
AS 
BEGIN 
    DECLARE @databaseName NVARCHAR(128)
    SET @databaseName = EVENTDATA().value('(/EVENT_INSTANCE/DatabaseName)[1]', 'NVARCHAR(128)')
    
    IF @databaseName = 'Marvel'
    BEGIN
        EXEC msdb.dbo.sp_add_notification @alert_name = N'MarvelDatabaseCreated',
                                           @operator_name = N'YourOperatorNameHere',
                                           @notification_method = 1,
                                           @database_name = N'Marvel';
    END
END;
GO

-- Trigger for performing database validation after its creation
CREATE TRIGGER DatabaseValidationTrigger
ON ALL SERVER 
FOR CREATE_DATABASE 
AS 
BEGIN 
    DECLARE @databaseName NVARCHAR(128)
    SET @databaseName = EVENTDATA().value('(/EVENT_INSTANCE/DatabaseName)[1]', 'NVARCHAR(128)')
    
    IF @databaseName = 'Marvel'
    BEGIN
        -- Add database validation logic here
        PRINT 'Database validation executed for Marvel database.'
    END
END;
GO
CREATE PROCEDURE AddCharacter
    @Name NVARCHAR(100),
    @Gender NVARCHAR(10),
    @Age INT,
    @OriginID INT
AS
BEGIN
    INSERT INTO Characters (Name, Gender, Age, OriginID)
    VALUES (@Name, @Gender, @Age, @OriginID);
END;
CREATE PROCEDURE UpdateCharacter
    @CharacterID INT,
    @Name NVARCHAR(100),
    @Gender NVARCHAR(10),
    @Age INT,
    @OriginID INT
AS
BEGIN
    UPDATE Characters
    SET Name = @Name, Gender = @Gender, Age = @Age, OriginID = @OriginID
    WHERE CharacterID = @CharacterID;
END;
CREATE PROCEDURE DeleteCharacterByID
    @CharacterID INT
AS
BEGIN
    DELETE FROM Characters
    WHERE CharacterID = @CharacterID;
END;
CREATE PROCEDURE GetCharactersByOrigin
    @OriginID INT
AS
BEGIN
    SELECT * FROM Characters
    WHERE OriginID = @OriginID;
END;
CREATE PROCEDURE GetComicsByPublicationDate
    @PublicationDate DATE
AS
BEGIN
    SELECT * FROM Comics
    WHERE PublicationDate = @PublicationDate;
END;
CREATE PROCEDURE GetTeamsByCharacter
    @CharacterID INT
AS
BEGIN
    SELECT Teams.* FROM Teams
    INNER JOIN Characters ON Teams.TeamID = Characters.TeamID
    WHERE Characters.CharacterID = @CharacterID;
END;
CREATE PROCEDURE RenameTeam
    @TeamID INT,
    @NewTeamName NVARCHAR(100)
AS
BEGIN
    UPDATE Teams
    SET TeamName = @NewTeamName
    WHERE TeamID = @TeamID;
END;

CREATE PROCEDURE AddComic
    @Title NVARCHAR(100),
    @IssueNumber INT,
    @PublicationDate DATE
AS
BEGIN
    INSERT INTO Comics (Title, IssueNumber, PublicationDate)
    VALUES (@Title, @IssueNumber, @PublicationDate);
END;

CREATE PROCEDURE DeleteComicByID
    @ComicID INT
AS
BEGIN
    DELETE FROM Comics
    WHERE ComicID = @ComicID;
END;

CREATE PROCEDURE GetCharactersByPower
    @PowerName NVARCHAR(100)
AS
BEGIN
    SELECT Characters.* FROM Characters
    INNER JOIN Powers ON Characters.PowerID = Powers.PowerID
    WHERE Powers.PowerName = @PowerName;
END;

CREATE PROCEDURE ChangeComicPublicationDate
    @ComicID INT,
    @NewPublicationDate DATE
AS
BEGIN
    UPDATE Comics
    SET PublicationDate = @NewPublicationDate
    WHERE ComicID = @ComicID;
END;

CREATE PROCEDURE ChangeComicPublicationDate
    @ComicID INT,
    @NewPublicationDate DATE
AS
BEGIN
    UPDATE Comics
    SET PublicationDate = @NewPublicationDate
    WHERE ComicID = @ComicID;
END;

CREATE PROCEDURE GetMoviesReleasedAfterDate
    @ReleaseDate DATE
AS
BEGIN
    SELECT * FROM Movies
    WHERE ReleaseDate > @ReleaseDate;
END;

CREATE PROCEDURE AddStudioMovie
    @Title NVARCHAR(100),
    @ReleaseDate DATE
AS
BEGIN
    INSERT INTO Movies (Title, ReleaseDate)
    VALUES (@Title, @ReleaseDate);
END;

CREATE PROCEDURE GetSeriesStartedBeforeDate
    @StartDate DATE
AS
BEGIN
    SELECT * FROM Series
    WHERE StartDate < @StartDate;
END;

CREATE PROCEDURE DeleteSeriesByID
    @SeriesID INT
AS
BEGIN
    DELETE FROM Series
    WHERE SeriesID = @SeriesID;
END;
