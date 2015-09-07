# 607: Homework 1
# Daina Bouquin

# Assignment:  SQL and NULLs
# Please use the tables in the 'flights' database.
# Your deliverable should include the SQL queries that you write in support of your conclusions.
# You may use multiple queries to answer questions.

# 1. How many airplanes have listed speeds?

SELECT COUNT(speed) FROM planes
WHERE speed IS NOT NULL;
# = 23

# What is the minimum listed speed and the maximum listed speed?

SELECT MIN(speed) FROM planes
WHERE speed IS NOT NULL;
# = 90

SELECT MAX(speed) FROM planes
WHERE speed IS NOT NULL;
# = 432

# 2. What is the total distance flown by all of the planes in January 2013?

SELECT SUM(distance) FROM flights
WHERE year='2013' AND month='1';
# = 27188805
# What is the total distance flown by all of the planes in January 2013 where the tailnum is missing?

SELECT SUM(distance) FROM flights
WHERE year='2013' AND month='1' AND tailnum IS NULL;
# = 81763

# 3. What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer?
# Write this statement first using an INNER JOIN, then using a LEFT OUTER JOIN. How do your results compare?

# INNER JOIN
SELECT planes.manufacturer,(flights.distance)
FROM flights
INNER JOIN planes
ON flights.tailnum=planes.tailnum
WHERE flights.year='2013' AND flights.month='7' AND flights.day='5'
GROUP BY manufacturer;
# manufacturer,SUM(distance)
# 'AIRBUS','1617'
# 'AIRBUS INDUSTRIE','529'
# 'AMERICAN AIRCRAFT INC','733'
# 'BARKER JACK L','937'
# 'BOEING','1400'
# 'BOMBARDIER INC','488'
# 'CANADAIR','228'
# 'CESSNA','764'
# 'DOUGLAS','1089'
# 'EMBRAER','200'
# 'GULFSTREAM AEROSPACE','502'
# 'MCDONNELL DOUGLAS','733'
# 'MCDONNELL DOUGLAS AIRCRAFT CO','1096'
# 'MCDONNELL DOUGLAS CORPORATION','1076'

# LEFT OUTTER JOIN -- * no "OUTTER LEFT JOIN" in mySQL, just called "LEFT JOIN"
SELECT planes.manufacturer,(flights.distance)
FROM flights
LEFT JOIN planes
ON flights.tailnum=planes.tailnum
WHERE flights.year='2013' AND flights.month='7' AND flights.day='5'
GROUP BY manufacturer;
# manufacturer,SUM(distance)
# NULL,'1089' * This is the difference, the result is NULL in the right side when there is no match.
# 'AIRBUS','1617'
# 'AIRBUS INDUSTRIE','529'
# 'AMERICAN AIRCRAFT INC','733'
# 'BARKER JACK L','937'
# 'BOEING','1400'
# 'BOMBARDIER INC','488'
# 'CANADAIR','228'
# 'CESSNA','764'
# 'DOUGLAS','1089'
# 'EMBRAER','200'
# 'GULFSTREAM AEROSPACE','502'
# 'MCDONNELL DOUGLAS','733'
# 'MCDONNELL DOUGLAS AIRCRAFT CO','1096'
# 'MCDONNELL DOUGLAS CORPORATION','1076'

# 4. Write and answer at least one question of your own choosing that joins information from
# at least three of the tables in the flights database.

# Select the FAA code, longitude and latitude of all airports that had planes
# landing with max speeds greater than 300 mph in May 2013
SELECT airports.faa, airports.lon, airports.lat
FROM airports
INNER JOIN flights
ON flights.dest=airports.faa
INNER JOIN planes
ON planes.tailnum=flights.tailnum
WHERE flights.year='2013' AND flights.month='5' AND planes.speed > '300'
GROUP BY airports.faa;
# faa,lon,lat
# 'ATL','-84.428067','33.636719'
# 'DTW','-83.353389','42.212444'
