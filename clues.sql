-- Clue #1: We recently got word that someone fitting Carmen Sandiego's description has been traveling through Southern Europe. She's most likely traveling someplace where she won't be noticed, so find the least populated country in Southern Europe, and we'll start looking for her there.
 
-- Write SQL query here
SELECT name
FROM countries
WHERE region = 'Southern Europe'
ORDER BY population ASC
LIMIT 1;




-- Clue #2: Now that we're here, we have insight that Carmen was seen attending language classes in this country's officially recognized language. Check our databases and find out what language is spoken in this country, so we can call in a translator to work with you.

-- Write SQL query here
SELECT l.language
FROM countries c
JOIN countrylanguages l ON c.code = l.countrycode
WHERE c.name = 'Holy See (Vatican City State)' AND l.isofficial = 'T';

-- Clue #3: We have new news on the classes Carmen attended – our gumshoes tell us she's moved on to a different country, a country where people speak only the language she was learning. Find out which nearby country speaks nothing but that language.

-- Write SQL query here
WITH vatican_language AS (
    SELECT l.language
    FROM countries c
    JOIN countrylanguages l ON c.code = l.countrycode
    WHERE c.name = 'Holy See (Vatican City State)' AND l.isofficial = 'T'
)

SELECT c.name
FROM countries c
JOIN countrylanguages l ON c.code = l.countrycode
WHERE l.language IN (SELECT language FROM vatican_language)
GROUP BY c.name
HAVING COUNT(*) = 1;

-- Clue #4: We're booking the first flight out – maybe we've actually got a chance to catch her this time. There are only two cities she could be flying to in the country. One is named the same as the country – that would be too obvious. We're following our gut on this one; find out what other city in that country she might be flying to.

-- Write SQL query here
SELECT name
FROM cities
WHERE countrycode = (
    SELECT code
    FROM countries
    WHERE name = 'Italy'
)
AND name != 'Rome';  

-- Clue #5: Oh no, she pulled a switch – there are two cities with very similar names, but in totally different parts of the globe! She's headed to South America as we speak; go find a city whose name is like the one we were headed to, but doesn't end the same. Find out the city, and do another search for what country it's in. Hurry!

-- Write SQL query here
SELECT c.name, c.countrycode
FROM cities c
JOIN countries co ON c.countrycode = co.code
WHERE co.continent = 'South America'
AND (
    c.name LIKE '%Rom%' OR
    c.name LIKE '%Mil%' OR
    c.name LIKE '%Nap%' OR
    c.name LIKE '%Tor%' OR
    c.name LIKE '%Pal%' OR
    c.name LIKE '%Gen%' OR
    c.name LIKE '%Bol%' OR
    c.name LIKE '%Fir%' OR
    c.name LIKE '%Cat%' OR
    c.name LIKE '%Bar%' OR
    c.name LIKE '%Ven%' OR
    c.name LIKE '%Mes%' OR
    c.name LIKE '%Ver%' OR
    c.name LIKE '%Tri%' OR
    c.name LIKE '%Pad%' OR
    c.name LIKE '%Tar%' OR
    c.name LIKE '%Bre%' OR
    c.name LIKE '%Reg%' OR
    c.name LIKE '%Mod%' OR
    c.name LIKE '%Pra%' OR
    c.name LIKE '%Par%' OR
    c.name LIKE '%Cag%' OR
    c.name LIKE '%Liv%' OR
    c.name LIKE '%Per%' OR
    c.name LIKE '%Fog%' OR
    c.name LIKE '%Sal%' OR
    c.name LIKE '%Rav%' OR
    c.name LIKE '%Fer%' OR
    c.name LIKE '%Rim%' OR
    c.name LIKE '%Syr%' OR
    c.name LIKE '%Sas%' OR
    c.name LIKE '%Mon%' OR
    c.name LIKE '%Ber%' OR
    c.name LIKE '%Pes%' OR
    c.name LIKE '%Lat%' OR
    c.name LIKE '%Vic%' OR
    c.name LIKE '%Ter%' OR
    c.name LIKE '%For%' OR
    c.name LIKE '%Tre%' OR
    c.name LIKE '%Nov%' OR
    c.name LIKE '%Pia%' OR
    c.name LIKE '%Lec%' OR
    c.name LIKE '%Bol%' OR
    c.name LIKE '%Cat%' OR
    c.name LIKE '%Spe%' OR
    c.name LIKE '%Udi%' OR
    c.name LIKE '%Torre%'
)
AND c.name NOT LIKE '%a';  

-- Clue #6: We're close! Our South American agent says she just got a taxi at the airport, and is headed towards
-- the capital! Look up the country's capital, and get there pronto! Send us the name of where you're headed and we'll
-- follow right behind you!

-- Write SQL query here
SELECT name
FROM cities
WHERE id = (
    SELECT capital
    FROM countries
    WHERE code = 'ARG'  -- Country code for Argentina
);

-- Clue #7: She knows we're on to her – her taxi dropped her off at the international airport, and she beat us to the boarding gates. We have one chance to catch her, we just have to know where she's heading and beat her to the landing dock. Lucky for us, she's getting cocky. She left us a note (below), and I'm sure she thinks she's very clever, but if we can crack it, we can finally put her where she belongs – behind bars.


--               Our playdate of late has been unusually fun –
--               As an agent, I'll say, you've been a joy to outrun.
--               And while the food here is great, and the people – so nice!
--               I need a little more sunshine with my slice of life.
--               So I'm off to add one to the population I find
--               In a city of ninety-one thousand and now, eighty five.

SELECT name, countrycode
FROM cities
WHERE countrycode = 'ARG' 
  AND population = 91101;

-- We're counting on you, gumshoe. Find out where she's headed, send us the info, and we'll be sure to meet her at the gates with bells on.
-- She is in Tandil based on my search.