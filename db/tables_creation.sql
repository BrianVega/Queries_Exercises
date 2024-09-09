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
-- Country with the biggest population (id and name of the country)
SELECT 'Country with the biggest population (id and name of the country)' AS info;
SELECT c.id, c.name
FROM country c;

-- Top 10 countries with the lowest population density (names of the countries)
SELECT 'Top 10 countries with the lowest population density (names of the countries)' AS info;
SELECT c.name
FROM country c
ORDER BY c.population DESC LIMIT 10;

-- Countries with population density higher than average across all countries
SELECT 'Countries with population density higher than average across all countries' AS info;
SELECT c.name
FROM country c
WHERE c.population > (SELECT AVG(country.population) FROM country);

-- Country with the longest name (if several countries have name of the same length, show all of them)
SELECT 'Country with the longest name (if several countries have name of the same length, show all of them)' AS info;
SELECT c.name
FROM country c
WHERE LENGTH(c.name) = (SELECT DISTINCT LENGTH((SELECT c.name FROM country c ORDER BY LENGTH(c.name) DESC LIMIT 1)));

-- All countries with name containing letter “F”, sorted in alphabetical order
SELECT 'All countries with name containing letter “F”, sorted in alphabetical order' AS info;
SELECT c.name
FROM country c
WHERE c.name like '%F%'
ORDER BY c.name;

-- Country which has a population, closest to the average population of all countries
SELECT 'Country which has a population, closest to the average population of all countries' AS info;
SELECT c.name, c.population
FROM country c
WHERE c.population <= (SELECT AVG(country.population) FROM country)
ORDER BY c.population DESC LIMIT 1;

-- Count of countries for each continent
SELECT 'Count of countries for each continent' AS info;
SELECT c.name, COUNT(*)
FROM country
         INNER JOIN continent c on country.continent_id = c.id
GROUP BY c.name;

-- Total area for each continent (print continent name and total area), sorted by area from biggest to smallest
SELECT 'Total area for each continent (continent name and total area), sorted by area from biggest to smallest' AS info;
SELECT c.name, SUM(c2.area) as area
FROM continent c
         INNER JOIN country c2 ON c.id = c2.continent_id
GROUP BY c.name
ORDER BY area DESC;

-- Average population density per continent
SELECT 'Average population density per continent' AS info;
SELECT c.name, AVG(c2.population) as population
FROM continent c
         INNER JOIN country c2 ON c.id = c2.continent_id
GROUP BY c.name;

-- For each continent, find a country with the smallest area (print continent name, country name, and area)
SELECT 'For each continent, find a country with the smallest area (continent name, country name, and area)' AS info;
SELECT c.name, c2.name, c2.area
FROM continent c
         INNER JOIN country c2 ON c.id = c2.continent_id
WHERE c2.area = (SELECT MIN(co2.area) FROM country co2 WHERE co2.continent_id = c.id);

-- Find all continents with average country population less than 20 million
SELECT 'Find all continents with average country population less than 20 million' AS info;
SELECT c.name, AVG(c2.population) as average
FROM continent c
         INNER JOIN country c2 ON c.id = c2.continent_id
GROUP BY c.name
HAVING AVG(c2.population) < 20000000;

-- Person with the biggest number of citizenships
SELECT 'Person with the biggest number of citizenships' AS info;
SELECT p.name, COUNT(*) as citizenships
FROM person p
         INNER JOIN person_citizenship pc ON p.id = pc.person_id
GROUP BY p.name
ORDER BY citizenships DESC LIMIT 1;

-- All people who have no citizenship
SELECT 'All people who have no citizenship' AS info;
SELECT p.name, COUNT(*) as citizenships
FROM person p
         INNER JOIN person_citizenship pc ON p.id = pc.person_id
GROUP BY p.name
HAVING COUNT(*) = 0;

-- Country with the least people in People table
SELECT 'Country with the least people in People table' AS info;
SELECT cou.name, COUNT(pc.person_id) as people_with_citizenship
FROM country cou
         INNER JOIN person_citizenship pc ON cou.id = pc.country_id
GROUP BY cou.name
ORDER BY people_with_citizenship LIMIT 1;

-- Continent with the most people in People table
SELECT 'Continent with the most people in People table' AS info;
SELECT con.name, COUNT(pc.person_id) as total_people
FROM continent con
         INNER JOIN country cou ON con.id = cou.continent_id
         INNER JOIN person_citizenship pc ON con.id = pc.country_id
GROUP BY con.name
ORDER BY total_people LIMIT 1;

-- Find pairs of people with the same name (print 2 ids and the name)
SELECT 'Find pairs of people with the same name (print 2 ids and the name)' AS info;
SELECT p1.id, p2.id, p1.name
FROM person p1
         INNER JOIN person p2 ON p1.name = p2.name AND p1.id < p2.id;
