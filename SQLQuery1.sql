USE Marvel;
GO

-- Update Script

USE Marvel;
GO

-- Update data in Characters table
UPDATE Characters
SET Gender = 'Male'
WHERE Name = 'Iron Man';

-- Update data in Comics table
UPDATE Comics
SET Title = 'The Amazing Spider-Man'
WHERE Title = 'Spider-Man';

-- Update data in Teams table
UPDATE Teams
SET TeamName = 'Avengers'
WHERE TeamID = 1;

-- Add more update statements as needed
