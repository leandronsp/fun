-- Users
DROP TABLE IF EXISTS users CASCADE; -- CASCADE forces to drop the table despite of relations, constraints, materialized views
CREATE TABLE
	users
AS
	SELECT
		generate_series(1, 10) AS id,
		concat('User ', generate_series(1, 10)) AS name;

-- Movies
DROP TABLE IF EXISTS movies CASCADE;
CREATE TABLE
	movies
AS
	SELECT
		generate_series(1, 50) AS id,
		concat('Movie ', generate_series(1, 50)) AS name;

-- Ratings
DROP TABLE IF EXISTS movies_ratings CASCADE;
CREATE TABLE
	movies_ratings
AS
	SELECT
		generate_series(1, 100) AS id,
		(random() * 10)::integer AS user_id,
		(random() * 50)::integer AS movie_id,
		(random() * 10)::integer AS rating;

-- Query
SELECT 
	users.name,
	movies.name,
	rating
FROM 
	movies_ratings
JOIN 
	users ON users.id = movies_ratings.user_id
JOIN 
	movies ON movies.id = movies_ratings.movie_id
ORDER BY
	rating DESC