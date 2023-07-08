DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS movies_ratings;

CREATE TABLE users (id INTEGER, name VARCHAR(250));
CREATE TABLE movies (id INTEGER, name VARCHAR(250));
CREATE TABLE movies_ratings (user_id INTEGER, movie_id INTEGER, rating INTEGER);

INSERT INTO users (id, name) VALUES (1, 'John'), (2, 'Ana'), (3, 'Jorge');
INSERT INTO movies (id, name) VALUES (1, 'Star Wars I'), (2, 'Star Wars II');

INSERT INTO movies_ratings
SELECT 
	users.id as user_id,
	movies.id as movie_id,
	(random() * 10)::integer as rating
FROM 
	users as users, 
	movies as movies;

WITH 
users_votes AS (
	SELECT 
		DISTINCT(users.id) as id,
		'user' as type,
		users.name as name,
		COUNT(movies_ratings.rating) OVER (PARTITION BY users.id) AS votes
	FROM users
	LEFT JOIN movies_ratings ON users.id = movies_ratings.user_id
	ORDER BY votes DESC
),
movies_votes AS (
	SELECT 
		DISTINCT(movies.id) as id,
		'movie' as type,
		movies.name as name,
		COUNT(movies_ratings.rating) OVER (PARTITION BY movies.id) AS votes
	FROM movies
	LEFT JOIN movies_ratings ON movies.id = movies_ratings.movie_id
	ORDER BY votes DESC
)
SELECT * FROM users_votes 
UNION
SELECT * FROM movies_votes