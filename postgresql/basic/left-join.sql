DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS movies_ratings;

CREATE TABLE users (id INTEGER, name VARCHAR(250));
CREATE TABLE movies (id INTEGER, name VARCHAR(250));
CREATE TABLE movies_ratings (user_id INTEGER, movie_id INTEGER, rating INTEGER);

INSERT INTO users (id, name) VALUES (1, 'John'), (2, 'Ana'), (3, 'Jorge');
INSERT INTO movies (id, name) VALUES (1, 'Star Wars I'), (2, 'Star Wars II');

INSERT INTO
	movies_ratings (user_id, movie_id, rating)
VALUES
	(1, 1, 7),
	(1, 2, 8),
	(2, 1, 6),
	(2, 2, 10);

SELECT
	users.name,
	movies.name,
	movies_ratings.rating
FROM movies_ratings
JOIN users ON users.id = movies_ratings.user_id
JOIN movies ON movies.id = movies_ratings.movie_id
ORDER BY movies_ratings.rating DESC;

SELECT
	users.name,
	COUNT(movies_ratings.rating) AS votes
FROM users
LEFT JOIN movies_ratings ON users.id = movies_ratings.user_id
GROUP BY users.name
ORDER BY COUNT(movies_ratings.rating) DESC;
