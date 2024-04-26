USE Marvel;
GO

-- 1. Get all characters and their origins
SELECT Characters.Name AS CharacterName, Origins.OriginName
FROM Characters
JOIN Origins ON Characters.OriginID = Origins.OriginID;

-- 2. Get a list of comics ordered by publication date
SELECT Title, IssueNumber, PublicationDate
FROM Comics
ORDER BY PublicationDate;

-- 3. Get the list of teams and the number of characters in each team
SELECT Teams.TeamName, COUNT(CharacterTeams.CharacterID) AS NumberOfCharacters
FROM Teams
LEFT JOIN CharacterTeams ON Teams.TeamID = CharacterTeams.TeamID
GROUP BY Teams.TeamName;

-- 4. Get a list of characters with their superpowers
SELECT Characters.Name, Powers.PowerName
FROM Characters
LEFT JOIN CharacterPowers ON Characters.CharacterID = CharacterPowers.CharacterID
LEFT JOIN Powers ON CharacterPowers.PowerID = Powers.PowerID;

-- 5. Get the list of events and their dates
SELECT EventName, EventDate
FROM Events;

-- 6. Get all movies ordered by release date
SELECT Title, ReleaseDate
FROM Movies
ORDER BY ReleaseDate;

-- 7. Get the list of series and their start dates
SELECT Title, StartDate
FROM Series;

-- 8. Get the list of creators and the number of characters created by each of them
SELECT Creators.Name, COUNT(CharacterCreators.CharacterID) AS NumberOfCharactersCreated
FROM Creators
LEFT JOIN CharacterCreators ON Creators.CreatorID = CharacterCreators.CreatorID
GROUP BY Creators.Name;

-- 9. Get the list of relationships between characters
SELECT Character1.Name AS Character1Name, Character2.Name AS Character2Name, Relationships.RelationshipType
FROM Relationships
JOIN Characters AS Character1 ON Relationships.Character1ID = Character1.CharacterID
JOIN Characters AS Character2 ON Relationships.Character2ID = Character2.CharacterID;

-- 10. Get all characters whose age is over 100 years
SELECT Name, Age
FROM Characters
WHERE Age > 100;
