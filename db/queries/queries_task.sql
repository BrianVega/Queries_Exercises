-- 1. Write SQL queries to find the following data about countries:
-- Country with the biggest population (id and name of the country)
SELECT c.id, c.name
FROM country c;

-- Top 10 countries with the lowest population density (names of the countries)
SELECT c.name
FROM country c
ORDER BY  c.population
        DESC LIMIT 10;

-- Countries with population density higher than average across all countries
SELECT c.name
FROM country c
WHERE c.population > (SELECT AVG(country.population)
                      FROM country);

-- Country with the longest name (if several countries have name of the same length, show all of them)
SELECT c.name
FROM country c
WHERE LENGTH(c.name) = (SELECT DISTINCT
                            (LENGTH((
                                SELECT c.name
                                FROM country c
                                ORDER BY LENGTH(c.name)
                                        desc LIMIT 1))));

-- All countries with name containing letter “F”, sorted in alphabetical order
SELECT c.name
FROM country c
WHERE c.name like '%F%'
ORDER BY c.name

-- Country which has a population, closest to the average population of all countries
SELECT c.name, c.population
FROM country c
WHERE c.population <= (SELECT AVG(country.population)
                       FROM country)
ORDER BY c.population DESC LIMIT 1;


-- 2. Write SQL queries to find the following data about countries and continents:
-- Count of countries for each continent
select c.name, COUNT(*)
FROM country
         INNER JOIN continent c on country.continent_id = c.id
GROUP BY c.name;

-- Total area for each continent (print continent name and total area), sorted by area from biggest to smallest
SELECT c.name, SUM(c2.area) as area
FROM continent c
         INNER JOIN country c2 ON c.id = c2.continent_id
GROUP BY c.name
order by area DESC;

-- Average population density per continent
SELECT c.name, AVG(c2.population) as population
FROM continent c
         INNER JOIN country c2 ON c.id = c2.continent_id
GROUP BY c.name;

-- For each continent, find a country with the smallest area (print continent name, country name and area)
SELECT c.name, c2.name, c2.area
FROM continent c
         INNER JOIN country c2 ON c.id = c2.continent_id
WHERE c2.area = (SELECT MIN(co2.area) from country co2 WHERE co2.continent_id = c.id);

-- Find all continents, which have average country population less than 20 million
SELECT c.name, AVG(c2.population) as average
FROM continent c
         INNER JOIN country c2 ON c.id = c2.continent_id
GROUP BY c.name
HAVING AVG(c2.population) < 20000000;

-- 3. Write SQL queries to find the following data about people
-- Person with the biggest number of citizenships
SELECT p.name, COUNT(*) as citizenships
FROM person p
         INNER JOIN person_citizenship pc ON p.id = pc.person_id
GROUP BY p.name
ORDER BY citizenships
        DESC LIMIT 1;

-- All people who have no citizenship
SELECT p.name, COUNT(*) as citizenships
FROM person p
         INNER JOIN person_citizenship pc ON p.id = pc.person_id
GROUP BY p.name
HAVING COUNT(*) = 0;

-- Country with the least people in People table
SELECT cou.name, COUNT(pc.person_id) as people_with_citizenship
FROM country cou
         INNER JOIN person_citizenship pc ON cou.id = pc.country_id
GROUP BY cou.name
ORDER BY people_with_citizenship
    LIMIT 1;

-- Continent with the most people in People table
SELECT con.name, COUNT(pc.person_id) as total_people
FROM continent con
         INNER JOIN country cou ON con.id = cou.continent_id
         INNER JOIN person_citizenship pc ON con.id = pc.country_id
group by con.name
ORDER BY total_people
    LIMIT 1;

-- Find pairs of people with the same name - print 2 ids and the name
SELECT p1.id, p2.id, p1.name
FROM person p1
         INNER JOIN person p2 on p1.name = p2.name AND p1.id < p2.id
