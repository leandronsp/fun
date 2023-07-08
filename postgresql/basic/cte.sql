DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS movies_ratings;

CREATE TABLE users (id INTEGER, name VARCHAR(250));
CREATE TABLE movies (id INTEGER, name VARCHAR(250));
CREATE TABLE movies_ratings (user_id INTEGER, movie_id INTEGER, rating INTEGER);

INSERT INTO users (id, name) VALUES (1, 'John'), (2, 'Ana'), (3, 'Jorge');
INSERT INTO movies (id, name) VALUES (1, 'Star Wars I'), (2, 'Star Wars II');

SELECT
	users.id as user_id,
	movies.id as movie_id,
	(random() * 10)::integer as rating
FROM
	users as users,
	movies as movies;

WITH users_movies AS (
	SELECT
		users.id as user_id,
		movies.id as movie_id,
		(random() * 10)::integer as rating
	FROM
		users as users,
		movies as movies
)
INSERT INTO movies_ratings SELECT * FROM users_movies;

WITH
users_votes AS (
	SELECT
		users.name,
		COUNT(movies_ratings.rating) AS votes
	FROM users
	LEFT JOIN movies_ratings ON users.id = movies_ratings.user_id
	GROUP BY users.name
	ORDER BY votes DESC
)
SELECT * FROM users_votes;
