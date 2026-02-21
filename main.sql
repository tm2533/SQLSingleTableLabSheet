
-- Single Table Lab Sheet

-- Create table
CREATE TABLE pet (
    name VARCHAR(20), 
    owner VARCHAR(20), 
    species VARCHAR(20), 
    sex CHAR(1), 
    checkups SMALLINT UNSIGNED, 
    birth DATE, 
    death DATE
);

-- Check schema and table
. schema
. table

-- Add data

INSERT INTO pet (name,owner,species,sex,checkups,birth,death)VALUES
('Fluffy','Harold','cat','f',5,'2001-02-04',NULL),
('Claws','Gwen','cat','m',2,'2000-03-17',NULL),
('Buffy','Harold','dog','f',7,'1999-05-13',NULL),
('Fang','Benny','dog','m',4,'2000-08-27',NULL),
('Bowser','Diane','dog','m',8,'1998-08-31','2001-07-29'),
('Chirpy','Gwen','bird','f',0,'2002-09-11',NULL),
('Whistler','Gwen','bird','',1,'2001-12-09',NULL),
('Slim','Benny','snake','m',5,'2001-04-29',NULL);

-- Example queris
SELECT * FROM pet;
SELECT * FROM pet WHERE sex = 'm';
SELECT owner FROM pet WHERE sex = 'm';
SELECT name, species, sex FROM pet WHERE species = 'snake' OR species = 'bird';

-- Question 1
/*
Q1-1. The names of owners and their pet's name for all pets who are female.
Q1-2. The names and birth dates of pets which are dogs.
Q1-3. The names of the owners of birds.
Q1-4. The species of pets who are female.
Q1-5. The names and birth dates of pets which are cats or birds.
Q1-6. The names and species of pets which are cats or birds and which are female.
*/

-- Q1-1. The names of owners and their pet's name for all pets who are female.
SELECT owner AS owner_name, name AS pet_name
FROM pet
WHERE sex = 'f';

-- Q1-2. The names and birth dates of pets which are dogs.
SELECT name AS pet_name, birth
FROM pet
WHERE species = 'dog';

-- Q1-3. The names of the owners of birds.
SELECT owner AS owner_name
FROM pet
WHERE species = 'bird';

-- Q1-4. The species of pets who are female.
SELECT species
FROM pet
WHERE sex = 'f';

-- Q1-5. The names and birth dates of pets which are cats or birds.
SELECT name AS pet_name, birth
FROM pet
WHERE species IN ('cat', 'bird');

-- Q1-6. The names and species of pets which are cats or birds and which are female.
SELECT name AS pet_name, species
FROM pet
WHERE species IN ('cat', 'bird') AND sex = 'f';

-- Question 2
/*
Q2-1. The names of owners and their pets where the pet's name ends with “er” or “all”
Q2-2. The names of any pets whose owner's name contains an "e"
Q2-3. The names of all pets whose name does not end with "fy"
Q2-4. All pet names whose owners name is only four characters long
Q2-5. All owners whose names begin and end with one of the first five letters of the alphabet
Q2-6. Repeat the previous query, but make the query sensitive to the case of letters of the alphabet the
characters in the name
*/
SELECT name FROM pet WHERE sex < 'm';
SELECT name FROM pet WHERE name >= 'F';
SELECT name FROM pet WHERE name >= 'f';
SELECT name, owner FROM pet WHERE name >= 'F' AND owner >= 'F';
SELECT name, owner FROM pet WHERE name LIKE 'F%';
SELECT name, owner FROM pet WHERE name LIKE 'F%' OR name LIKE '%f';

-- Q2-1. The names of owners and their pets where the pet's name ends with “er” or “all”
SELECT owner, name FROM pet WHERE name like '%er' OR name LIKE '%all';

-- Q2-2. The names of any pets whose owner's name contains an "e"
SELECT name, owner FROM pet WHERE owner LIKE '%e%';

-- Q2-3. The names of all pets whose name does not end with "er"
SELECT name FROM pet WHERE name LIKE '%er%';
SELECT name FROM pet WHERE name NOT LIKE '%er%';

-- Q2-4. All pet names whose owners name is only four characters long
SELECT name, owner FROM pet WHERE LENGTH(owner) = 4;

-- STOPPED HERE
-- Q2-5. All owners whose names begin and end with one of the first five letters of the alphabet
SELECT 
    owner, 
    SUBSTR(owner, 1, 1) AS first_letter, 
    SUBSTR(owner, LENGTH(owner), LENGTH(owner)) AS last_letter
FROM pet WHERE 
    -- Begins with one of first 5 letters
    LOWER(SUBSTR(owner, 1, 1)) IN ('a', 'b', 'c', 'd', 'e')
    -- Ends with one of first 5 letters
    OR LOWER(SUBSTR(owner, LENGTH(owner), LENGTH(owner))) IN ('a', 'b', 'c', 'd', 'e');

-- Q2-6. Repeat the previous query, but make the query sensitive to the case of letters of the alphabet the
-- characters in the name
SELECT 
    owner, 
    SUBSTR(owner, 1, 1) AS first_letter, 
    SUBSTR(owner, LENGTH(owner), LENGTH(owner)) AS last_letter
FROM pet WHERE 
    -- Begins with one of first 5 UPPERCASE letters 
    SUBSTR(owner, 1, 1) IN ('A', 'B', 'C', 'D', 'E')
    -- Ends with one of first 5 lowercase letters
    OR SUBSTR(owner, LENGTH(owner), LENGTH(owner)) IN ('a', 'b', 'c', 'd', 'e');

SELECT name, birth FROM pet ORDER BY birth;
SELECT name, birth FROM pet ORDER BY birth DESC;
SELECT name, species, birth FROM pet ORDER BY species, birth DESC;

-- Dates
SELECT 
    birth, 
    STRFTIME('%d', birth) AS birth_day, 
    STRFTIME('%m', birth) AS birth_month, 
    STRFTIME('%Y', birth) AS birth_year, 
    death
FROM pet
WHERE death IS NOT NULL;

SELECT 
    birth, 
    STRFTIME('%d', birth) AS birth_day, 
    STRFTIME('%m', birth) AS birth_month, 
    STRFTIME('%Y', birth) AS birth_year, 
    STRFTIME('%m', 'now') AS current_month,
    death
FROM pet
WHERE death IS NOT NULL
    AND STRFTIME('%m', birth) = STRFTIME('%m', 'now');

-- Grouping
SELECT owner, name, birth, MIN(STRFTIME('%Y', birth)) AS birth_year 
FROM pet
GROUP BY owner;

-- Question 3
/*
Q3-1. The average number of check-ups that each owner has made with their pets
Q3-2. The number of pets of each species in ascending order
Q3-3. The number of pets of each species that each owner has
Q3-4. The number of distinct species of pet each owner has
Q3-5. The number of pets of each gender there are in the database, where the gender is known
Q3-6. The number of birds each owner has
Q3-7. The total number of check-ups each owner has made with all their pets
*/

-- Q3-1. The average number of check-ups that each owner has made with their pets
SELECT owner, AVG(checkups) AS avg_n_checkups
FROM pet
GROUP BY owner
ORDER BY avg_n_checkups DESC;

-- Q3-2. The number of pets of each species in ascending order
SELECT species, COUNT(1) AS n_pets
FROM pet
GROUP BY species
ORDER BY n_pets DESC;

-- Q3-3. The number of pets of each species that each owner has
SELECT owner, species, COUNT(1) AS n_pets
FROM PET
GROUP BY owner, species
ORDER BY owner, n_pets DESC;

-- Q3-4. The number of distinct species of pet each owner has
SELECT owner, COUNT(DISTINCT species) AS n_distinct_species
FROM PET
GROUP BY owner
ORDER BY n_distinct_species DESC;

-- Q3-5. The number of pets of each gender there are in the database, where the gender is known
SELECT sex, COUNT(1) AS n_pets
FROM PET
WHERE sex != '' 
    AND sex IS NOT NULL
GROUP BY sex
ORDER BY n_pets DESC;

-- Q3-6. The number of birds each owner has
SELECT owner, COUNT(1) AS n_birds
FROM PET
WHERE species = 'bird'
GROUP BY owner
ORDER BY n_birds DESC;

-- Q3-7. The total number of check-ups each owner has made with all their pets
SELECT owner, SUM(checkups) AS total_n_checkups
FROM PET
GROUP BY owner
ORDER BY total_n_checkups DESC;
