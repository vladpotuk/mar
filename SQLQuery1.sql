USE Marvel;
GO

-- Insert Origins
INSERT INTO Origins (OriginID, OriginName) VALUES (1, 'Earth');
INSERT INTO Origins (OriginID, OriginName) VALUES (2, 'Asgard');
INSERT INTO Origins (OriginID, OriginName) VALUES (3, 'Xandar');


-- Insert Characters
INSERT INTO Characters (CharacterID, Name, Gender, Age, OriginID) VALUES (1, 'Iron Man', 'Male', 40, 1);
INSERT INTO Characters (CharacterID, Name, Gender, Age, OriginID) VALUES (2, 'Thor', 'Male', 1500, 2);
INSERT INTO Characters (CharacterID, Name, Gender, Age, OriginID) VALUES (3, 'Star-Lord', 'Male', 35, 3);


-- Insert Comics
INSERT INTO Comics (ComicID, Title, IssueNumber, PublicationDate) VALUES (1, 'Iron Man Vol. 1', 1, '1968-05-01');
INSERT INTO Comics (ComicID, Title, IssueNumber, PublicationDate) VALUES (2, 'Thor Vol. 1', 1, '1962-08-01');
INSERT INTO Comics (ComicID, Title, IssueNumber, PublicationDate) VALUES (3, 'Star-Lord Vol. 1', 1, '1976-01-01');


-- Insert Teams
INSERT INTO Teams (TeamID, TeamName) VALUES (1, 'Avengers');
INSERT INTO Teams (TeamID, TeamName) VALUES (2, 'Guardians of the Galaxy');


-- Insert Powers
INSERT INTO Powers (PowerID, PowerName, Description) VALUES (1, 'Flight', 'Ability to fly using energy or technology');
INSERT INTO Powers (PowerID, PowerName, Description) VALUES (2, 'Super Strength', 'Enhanced physical strength');
INSERT INTO Powers (PowerID, PowerName, Description) VALUES (3, 'Energy Blasts', 'Ability to emit blasts of energy from hands or eyes');


-- Insert Events
INSERT INTO Events (EventID, EventName, EventDate) VALUES (1, 'Avengers: Infinity War', '2018-04-27');
INSERT INTO Events (EventID, EventName, EventDate) VALUES (2, 'Guardians of the Galaxy Vol. 2 Premiere', '2017-05-05');


-- Insert Movies
INSERT INTO Movies (MovieID, Title, ReleaseDate) VALUES (1, 'Iron Man', '2008-05-02');
INSERT INTO Movies (MovieID, Title, ReleaseDate) VALUES (2, 'Thor', '2011-05-06');
INSERT INTO Movies (MovieID, Title, ReleaseDate) VALUES (3, 'Guardians of the Galaxy', '2014-08-01');


-- Insert Series
INSERT INTO Series (SeriesID, Title, StartDate) VALUES (1, 'Iron Man', '1994-09-24');
INSERT INTO Series (SeriesID, Title, StartDate) VALUES (2, 'Thor', '2011-04-03');
INSERT INTO Series (SeriesID, Title, StartDate) VALUES (3, 'Star-Lord', '2015-01-01');


-- Insert Creators
INSERT INTO Creators (CreatorID, Name) VALUES (1, 'Stan Lee');
INSERT INTO Creators (CreatorID, Name) VALUES (2, 'Jack Kirby');


-- Insert Relationships
INSERT INTO Relationships (RelationshipID, Character1ID, Character2ID, RelationshipType) VALUES (1, 1, 2, 'Teammates');
INSERT INTO Relationships (RelationshipID, Character1ID, Character2ID, RelationshipType) VALUES (2, 1, 3, 'Teammates');
