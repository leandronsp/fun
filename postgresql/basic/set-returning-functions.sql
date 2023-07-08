-- SET Returning Functions (more than one row)
SELECT generate_series(1, 10);

-- with labels
SELECT
	generate_series(1, 10) AS id,
	concat('User ', generate_series(1, 10)) AS name;

-- can use with multiple FROM's too
SELECT
	id, name
FROM
	generate_series(1, 10) AS id,
	concat('User ', id) AS name;

-- DROP TABLE
DROP TABLE IF EXISTS users;

-- CREATE TABLE from a resulting SELECT
CREATE TABLE
	users
AS
	SELECT
		generate_series(1, 10) AS id,
		concat('User ', generate_series(1, 10)) AS name;

-- SELECT all rows and columns from a table
SELECT * FROM users;