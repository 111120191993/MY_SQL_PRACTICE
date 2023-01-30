SELECT *FROM benn.college_football_players

SELECT *FROM benn.college_football_teams

SELECT teams.conference AS conference,
AVG(players.weight) AS average_weight
FROM benn.college_football_players players
JOIN benn.college_football_teams teams
ON teams.school_name = players.school_name
GROUP BY teams.conference 
ORDER BY AVG(players.weight) DESC

SELECT players.school_name,
players.player_name, 
players.position,
players.weight
FROM benn.college_football_players players
WHERE players.state='GA'
ORDER BY players.weight DESC

---- inner join

select players.school_name AS players_school_name,
teams.school_name AS teams_school_name
FROM benn.college_football_players players
INNER JOIN benn.college_football_teams teams
ON teams.school_name = players.school_name

SELECT players.player_name, 
players.school_name,
teams.conference
FROM benn.college_football_players players
INNER JOIN benn.college_football_teams teams
ON teams.school_name = players.school_name
WHERE teams.division = 'FBS (Division I-A Teams)'

---- outer join
select *FROM tutorial.crunchbase_companies

select *FROM tutorial.crunchbase_acquisitions


SELECT companies.permalink AS companies_permalink,
companies.name AS companies_name,
acquisitions.company_permalink AS acquisitions_permalink,
acquisitions.acquired_at AS acquired_date
FROM tutorial.crunchbase_companies companies
JOIN tutorial.crunchbase_acquisitions acquisitions
ON companies.permalink = acquisitions.company_permalink

--- left join
SELECT companies.permalink AS companies_permalink,
companies.name AS companies_name,
acquisitions.company_permalink AS acquisitions_permalink,
acquisitions.acquired_at AS acquired_date
FROM tutorial.crunchbase_companies companies
LEFT JOIN tutorial.crunchbase_acquisitions acquisitions
ON companies.permalink = acquisitions.company_permalink

SELECT COUNT(companies.permalink) AS rowcount_companies,
COUNT(acquisitions.company_permalink) AS rowcount_acquisitions
FROM tutorial.crunchbase_companies companies
INNER JOIN tutorial.crunchbase_acquisitions acquisitions
ON companies.permalink = acquisitions.company_permalink

SELECT COUNT(companies.permalink) AS rowcount_companies,
COUNT(acquisitions.company_permalink) AS rowcount_acquisitions
FROM tutorial.crunchbase_companies companies
LEFT JOIN tutorial.crunchbase_acquisitions acquisitions
ON companies.permalink = acquisitions.company_permalink

----right join
SELECT companies.permalink AS companies_permalink,
companies.name AS companies_name,
acquisitions.company_permalink AS acquisitions_permalink,
acquisitions.acquired_at AS acquired_date
FROM tutorial.crunchbase_companies companies
LEFT JOIN tutorial.crunchbase_acquisitions acquisitions
ON companies.permalink = acquisitions.company_permalink

---joins using WHERE and ON
SELECT companies.permalink AS companies_permalink,
companies.name AS companies_name,
acquisitions.company_permalink AS acquisitions_permalink,
acquisitions.acquired_at AS acquired_date
FROM tutorial.crunchbase_companies companies
LEFT JOIN tutorial.crunchbase_acquisitions acquisitions
ON companies.permalink = acquisitions.company_permalink
ORDER BY 1

----changing a columns data type

SELECT *FROM tutorial.crunchbase_companies_clean_date


SELECT funding_total_usd::varchar AS funding_total_string,
founded_at_clean :: varchar AS founded_string
FROM tutorial.crunchbase_companies_clean_date

SELECT cast(funding_total_usd AS varchar) AS funding_total_string,
cast(founded_at_clean AS varchar) AS founded_string
FROM tutorial.crunchbase_companies_clean_date

--- Date format
SELECT companies.permalink,
companies.founded_at_clean,
acquisitions.acquired_at_cleaned, 
acquisitions.acquired_at_cleaned - companies.founded_at_clean :: timestamp AS time_to_acquisition
FROM tutorial.crunchbase_companies_clean_date companies
JOIN tutorial.crunchbase_acquisitions_clean_date acquisitions
ON companies.permalink = acquisitions.company_permalink
WHERE founded_at_clean is NOT NULL

----using interval
SELECT companies.permalink,
companies.founded_at_clean,
companies.founded_at_clean :: timestamp +
interval '1 week' AS plus_one_week
FROM tutorial.crunchbase_companies_clean_date companies
WHERE founded_at_clean is NOT NULL

----using NOW()
SELECT companies.permalink,
companies.founded_at_clean,
NOW() - companies.founded_at_clean :: timestamp AS founded_time
FROM tutorial.crunchbase_companies_clean_date companies
WHERE founded_at_clean is NOT NULL

----CLEANING string functions
SELECT *from tutorial.sf_crime_incidents_2014_01


---LEFT ,RIGHT, LENGTH
SELECT incidnt_num,
date,
LEFT(date, 10) AS cleaned_data
FROM tutorial.sf_crime_incidents_2014_01

SELECT incidnt_num,
date,
LEFT(date, 10) AS cleaned_data,
RIGHT(date, 17) AS cleaned_time
FROM tutorial.sf_crime_incidents_2014_01

SELECT incidnt_num,
date,
LEFT(date, 10) AS cleaned_data,
RIGHT(date, length(date) - 11) AS cleaned_time
FROM tutorial.sf_crime_incidents_2014_01

---TRIM()
SELECT location,
trim(both '()' FROM location)
FROM tutorial.sf_crime_incidents_2014_01

---exercise
SELECT location,
trim(leading '(' FROM left(location, position()))

---- SUBSTRING
SELECT incidnt_num,
date,
substr(date,2,4) AS day
FROM tutorial.sf_crime_incidents_2014_01

----concat
SELECT incidnt_num,
day_of_week,
left(date, 10) AS cleaned_date,
concat(day_of_week, ', ', left(date,10)) AS day_and_date
FROM tutorial.sf_crime_incidents_2014_01

---can use || (pipe function) to concat
---query that creates a date column formatted YYYY-MM-DD
SELECT incidnt_num,
date,
substr(date, 7,4) || '-' || LEFT(date, 2) || '-' || substr(date,4,2) AS cleaned_date
from tutorial.sf_crime_incidents_2014_01

---UPPER,LOWER

SELECT incidnt_num,
category,
upper(LEFT(category, 1)) || lower(RIGHT(category, length(category) - 1)) AS cleaned_category
from tutorial.sf_crime_incidents_2014_01

----COALESCE- REPLACES NULL VALUES

SELECT incidnt_num,
descript,
COALESCE(descript, 'No Description')
FROM tutorial.sf_crime_incidents_2014_01
ORDER BY descript DESC

---- subquery- is nothing but a query inside a query. also called as nested query

SELECT sub.*
FROM (
SELECT *
FROM tutorial.sf_crime_incidents_2014_01
WHERE day_of_week = 'Friday'
) sub
WHERE sub.resolution = 'NONE'

SELECT sub.*
FROM (
SELECT * 
from tutorial.sf_crime_incidents_2014_01
WHERE descript= 'WARRANT ARREST'
) sub
WHERE sub.resolution= 'NONE'

---- WINDOW FUNCTIONS- ROW,RANK,DENSE

SELECT start_terminal,
start_time,
duration_seconds,
row_number() over (ORDER BY start_time) AS row_number
from tutorial.dc_bikeshare_q1_2012
WHERE start_time < '2012-01-08'


----partition by
SELECT start_terminal,
start_time,
duration_seconds,
row_number() over (partition BY start_terminal
ORDER BY start_time) AS row_number
from tutorial.dc_bikeshare_q1_2012
WHERE start_time < '2012-01-08'

---- rank()
SELECT start_terminal,
start_time,
duration_seconds,
RANK() over (partition BY start_terminal
ORDER BY start_time) AS rank_number
from tutorial.dc_bikeshare_q1_2012
WHERE start_time < '2012-01-08'

---- dense_rank()
SELECT start_terminal,
start_time,
duration_seconds,
DENSE_RANK() over (partition BY start_terminal
ORDER BY start_time) AS rank_number
from tutorial.dc_bikeshare_q1_2012
WHERE start_time < '2012-01-08'



