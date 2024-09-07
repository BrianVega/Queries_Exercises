-- Table for Continents
CREATE TABLE Continent (
                           id SERIAL PRIMARY KEY,
                           name VARCHAR(100) NOT NULL
);

-- Table for Countries
CREATE TABLE Country (
                         id SERIAL PRIMARY KEY,
                         name VARCHAR(100) NOT NULL,
                         population BIGINT NOT NULL,
                         area BIGINT NOT NULL,  -- in square kilometers
                         continent_id INT REFERENCES Continent(id) ON DELETE CASCADE
);

-- Table for People
CREATE TABLE Person (
                        id SERIAL PRIMARY KEY,
                        name VARCHAR(100) NOT NULL
);

-- Many-to-many relationship between Person and Country (for multiple citizenships)
CREATE TABLE Person_Citizenship (
                                    person_id INT REFERENCES Person(id) ON DELETE CASCADE,
                                    country_id INT REFERENCES Country(id) ON DELETE CASCADE,
                                    PRIMARY KEY (person_id, country_id)
);

-- Insert Continents
INSERT INTO Continent (name) VALUES
                                 ('Africa'),
                                 ('Asia'),
                                 ('Europe'),
                                 ('North America'),
                                 ('South America'),
                                 ('Australia'),
                                 ('Antarctica'),
                                 ('Oceania'),
                                 ('Central America'),
                                 ('Caribbean'),
                                 ('Middle East'),
                                 ('Caucasus'),
                                 ('Central Asia'),
                                 ('Southeast Asia'),
                                 ('Baltic States'),
                                 ('Scandinavia'),
                                 ('Western Europe');

-- Insert Countries
INSERT INTO Country (name, population, area, continent_id) VALUES
                                                               ('Nigeria', 206000000, 923768, 1),
                                                               ('South Africa', 60000000, 1219090, 1),
                                                               ('China', 1411778724, 9596961, 2),
                                                               ('India', 1380004385, 3287263, 2),
                                                               ('Germany', 83100000, 357114, 3),
                                                               ('France', 67400000, 551695, 3),
                                                               ('United States', 331000000, 9833520, 4),
                                                               ('Brazil', 212559417, 8515767, 5),
                                                               ('Australia', 25687041, 7692024, 6),
                                                               ('Canada', 37742154, 9976140, 4),
                                                               ('Mexico', 128932753, 1964375, 4),
                                                               ('Argentina', 45195777, 2780400, 5),
                                                               ('Colombia', 50882891, 1141748, 5),
                                                               ('Japan', 126476461, 377975, 2),
                                                               ('South Korea', 51269185, 100032, 2),
                                                               ('Russia', 145912025, 17098242, 3),
                                                               ('Turkey', 84339067, 783562, 3),
                                                               ('Egypt', 91250000, 1001450, 1),
                                                               ('Kenya', 53771296, 580367, 1);

-- Insert People
INSERT INTO Person (name) VALUES
                              ('John Doe'),
                              ('Jane Smith'),
                              ('Michael Johnson'),
                              ('Emily Davis'),
                              ('David Brown'),
                              ('Alice Johnson'),
                              ('Bob Brown'),
                              ('Carol White'),
                              ('Dan Green'),
                              ('Eva Black'),
                              ('Frank Blue'),
                              ('Grace Red'),
                              ('Hank Gray'),
                              ('Ivy Violet'),
                              ('Jack Orange');

-- Insert Citizenship (Multiple citizenships)
INSERT INTO Person_Citizenship (person_id, country_id) VALUES
                                                           (1, 1), (1, 3), -- John Doe (Nigeria, China)
                                                           (2, 4),         -- Jane Smith (India)
                                                           (3, 5),         -- Michael Johnson (Germany)
                                                           (4, 6),         -- Emily Davis (France)
                                                           (5, 8),         -- David Brown (Brazil)
                                                           (1, 7),         -- John Doe (United States)
                                                           (6, 1), (6, 2), -- Frank Blue (Canada, Mexico)
                                                           (7, 3), (7, 4), -- Grace Red (Argentina, Colombia)
                                                           (8, 5), (8, 6), -- Hank Gray (Japan, South Korea)
                                                           (9, 7), (9, 8), -- Ivy Violet (Russia, Turkey)
                                                           (10, 9), (10, 10), -- Jack Orange (Egypt, Kenya)
                                                           (2, 1), (2, 5), (2, 8), -- Bob Brown (Canada, Japan, Turkey)
                                                           (3, 2), (3, 4), (3, 6); -- Carol White (Mexico, Colombia, South Korea)

SELECT * FROM Person;