----AGGREGATE FUNCTIONS- COUNT,SUM,MIN,MAX,AVG
SELECT * FROM tutorial.aapl_historical_stock_price

select count(*) as totalcount from tutorial.aapl_historical_stock_price

select count(volume) from tutorial.aapl_historical_stock_price

select count(date) as date,
count(year) as year,
count(month) as month,
count(open) as open,
count(high) as high,
count(low) as low,
count(close) as close,
count(volume) as v from tutorial.aapl_historical_stock_price
---- from the above result we can see that the column high has the most null values and column open has less.

select sum(open)/count(open) as "AVG OPENING PRICE"
FROM tutorial.aapl_historical_stock_price

SELECT MIN(low) AS low
FROM tutorial.aapl_historical_stock_price

select max(close-open) as high
from tutorial.aapl_historical_stock_price

select avg(high) from tutorial.aapl_historical_stock_price
where high is not null

select avg(high) from tutorial.aapl_historical_stock_price


select avg(volume) from tutorial.aapl_historical_stock_price

SELECT YEAR, COUNT(*) AS YEAR
FROM tutorial.aapl_historical_stock_price
GROUP BY YEAR

SELECT year, MONTH, COUNT(*) 
FROM tutorial.aapl_historical_stock_price
GROUP BY YEAR,MONTH

select year, month,
sum(volume) as volume from tutorial.aapl_historical_stock_price
group by year,month
order by year, month

select avg(close-open),year
from tutorial.aapl_historical_stock_price
group by year
order by year

select year,month,
min(low) as lowest_price, max(high) as highest_price
from tutorial.aapl_historical_stock_price
group by year, month
order by year, month

select year, month, max(high) as highest_price
from tutorial.aapl_historical_stock_price
group by year, month
having max(high)>400
order by year,month

select distinct year from tutorial.aapl_historical_stock_price
order by year

select count(distinct month) as unique_months
from tutorial.aapl_historical_stock_price

select month, avg(volume) as avg_trade_volume
from tutorial.aapl_historical_stock_price
group by month
order by 2 desc

---Write a query that counts the number of unique values in the month column for each year.
select year, count(distinct month) from tutorial.aapl_historical_stock_price
group by year

---Write a query that separately counts the number of unique values in the month column and 
---the number of unique values in the `year` column.
select count(distinct month) as new_month, count(distinct year) as new_year
from tutorial.aapl_historical_stock_price

SELECT teams.conference, AVG(players.weight)
  FROM benn.college_football_players players
  JOIN benn.college_football_teams teams ON teams.school_name = players.school_name
 GROUP BY teams.conference ORDER BY AVG(players.weight) DESC
SELECT players.school_name, players.player_name, players.position, players.weight
  FROM benn.college_football_players players
 WHERE players.state = 'GA' ORDER BY players.weight DESC


SELECT players.school_name, teams.school_name
  FROM benn.college_football_players players
  JOIN benn.college_football_teams team ON teams.school_name = players.school_name
SELECT players.player_name, players.school_name, teams.conference
  FROM benn.college_football_players players
  JOIN benn.college_football_teams teams ON teams.school_name = players.school_name
 WHERE teams.division = 'FBS (Division I-A Teams)'