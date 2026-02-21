
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
SELECT owner as owner_name, name as pet_name
FROM pet
WHERE sex = 'f';

-- Q1-2. The names and birth dates of pets which are dogs.
SELECT name as pet_name, birth
FROM pet
WHERE species = 'dog';

-- Q1-3. The names of the owners of birds.
SELECT owner as owner_name
FROM pet
WHERE species = 'bird';

-- Q1-4. The species of pets who are female.
SELECT species
FROM pet
WHERE sex = 'f';

-- Q1-5. The names and birth dates of pets which are cats or birds.
SELECT name as pet_name, birth
FROM pet
WHERE species in ('cat', 'bird');

-- Q1-6. The names and species of pets which are cats or birds and which are female.
SELECT name as pet_name, species
FROM pet
WHERE species in ('cat', 'bird') AND sex = 'f';