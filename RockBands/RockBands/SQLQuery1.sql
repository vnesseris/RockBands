--Create Table With Rock Bands
CREATE TABLE rockBands(
id INTEGER PRIMARY KEY,
name VARCHAR(MAX) ,
origin VARCHAR(MAX),
era VARCHAR(MAX));

--Insert rock bands in the table
INSERT INTO rockBands
VALUES (1, 'AC/DC', 'Australia','1975-2020');

INSERT INTO rockBands
	VALUES 
	(2, 'Linkin Park', 'America','1996-2017'),
	(3, 'Metallica', 'America','1981-2020'),
	(4, 'Eagles', 'America','1972-2010');

SELECT * FROM rockBands;

--Create a table containing albums
CREATE TABLE albums (
id INTEGER PRIMARY KEY,
band_id INTEGER FOREIGN KEY REFERENCES rockBands(id),
name VARCHAR(MAX),
year INTEGER);

--Insert albums into table
INSERT INTO albums
VALUES 
	(1, 1, 'High Voltage', 1975),
	(2, 1, 'T.N.T.', 1975);

INSERT INTO albums
VALUES 
	(3, 1, 'Dirty Deeds Done Dirt Cheap', 1976),
	(4, 2, 'Hybrid Theory', 2000),
	(5, 2, 'Meteora', 2003),
	(6, 3,'Kill Em All', 1983),
	(7, 3, 'Ride The Lightning', 1984),
	(8, 4, 'Eagles', 1972),
	(9, 4, 'Desperado', 1973),
	(10, 4, 'On the Border', 1974);

--Finding The number of albums of each band
SELECT rockBands.name, COUNT(*) AS 'No. of Albums' 
FROM albums
LEFT JOIN rockBands
ON albums.band_id = rockBands.id
GROUP BY rockBands.name
ORDER BY rockBands.name;

SELECT albums.name, rockBands.name, albums.year 
FROM albums
JOIN rockBands
ON albums.band_id = rockBands.id;

SELECT albums.name, rockBands.name, albums.year 
FROM albums
JOIN rockBands
ON albums.band_id = rockBands.id
WHERE albums.year > 1980;

--Find the bands that have 3 or more albums in the table
SELECT albums.band_id, COUNT(*) AS 'No of Albums' INTO #bigBands
FROM albums
GROUP BY albums.band_id
HAVING COUNT(*) > 2;

SELECT * 
FROM #bigBands
JOIN rockBands
ON #bigBands.band_id = rockBands.id;

--Creating a new Column in albums containing the labels
ALTER TABLE albums
ADD label VARCHAR(MAX);

SELECT * FROM albums;
--Updating the Label in each album
UPDATE albums SET label = 'Albert' WHERE id = 1
GO
UPDATE albums SET label = 'Albert' WHERE id = 2
GO
UPDATE albums SET label = 'Albert/Atlantic' WHERE id = 3
GO
UPDATE albums SET label = 'Warner Bros' WHERE id = 4
GO
UPDATE albums SET label = 'Warner Bros/Machine Shop' WHERE id = 5
GO
UPDATE albums SET label = 'Megaforce' WHERE id = 6
GO
UPDATE albums SET label = 'Megaforce' WHERE id = 7
GO
UPDATE albums SET label = 'Asylum' WHERE id = 8
GO
UPDATE albums SET label = 'Asylum' WHERE id = 9
GO
UPDATE albums SET label = 'Asylum' WHERE id = 10
GO
				
SELECT * FROM albums;
--Creation of a table containing the best hits
CREATE TABLE best_hits(
song_id INTEGER PRIMARY KEY,
name VARCHAR(MAX),
band_id INTEGER FOREIGN KEY REFERENCES rockBands(id),
album_id INTEGER FOREIGN KEY REFERENCES albums(id),
duration REAL);
--Insert the best hits in the album
INSERT INTO best_hits 
VALUES (1, 'In the End', 2, 4, 3.36),
		(2, 'Crawling', 2, 4, 3.29),
		(3, 'Take it Easy', 4, 8, 3.34),
		(4, 'Twenty-One', 4, 9, 2.11),
		(5, 'The Four Horsemen', 3, 6, 7.13),
		(6, 'Ride On', 1, 3, 5.54),
		(7, 'Numb', 2, 5, 3.07),
		(8, 'One Step Closer', 2, 4, 2.35); 

SELECT * FROM best_hits;

SELECT * FROM best_hits
JOIN albums ON best_hits.album_id = albums.id
JOIN rockBands ON best_hits.band_id = rockBands.id;

--Selecting the songs between 1980 and 2000 
-- and have a duration between 3.0 and 4.2
SELECT best_hits.name, albums.name, rockBands.name
FROM best_hits
JOIN albums ON best_hits.album_id = albums.id
JOIN rockBands ON best_hits.band_id = rockBands.id
WHERE albums.year BETWEEN 1980 AND 2000 AND duration BETWEEN 3.0 AND 4.2;

--Finding the number of songs each band has in the album best_hits
SELECT band_id, COUNT(*) AS 'No of Songs' 
INTO #lovedBands
FROM best_hits
GROUP BY band_id
ORDER BY COUNT(*);
SELECT rockBands.name AS 'BAND' , #lovedBands.[No of Songs] 
FROM rockBands JOIN #lovedBands
ON rockBands.id = #lovedBands.band_id
ORDER BY #lovedBands.[No of Songs] DESC;

