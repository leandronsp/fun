-- VIEW
DROP VIEW IF EXISTS users_view;
CREATE VIEW
	users_view
AS
	SELECT
		generate_series(1, 10) AS id,
		concat('User ', generate_series(1, 10)) AS name;

SELECT * FROM users_view;

-- MATERIALIZED VIEW: same as "CREATE TABLE AS"
DROP MATERIALIZED VIEW IF EXISTS users_mview;
CREATE MATERIALIZED VIEW
	users_mview
AS
	SELECT
		generate_series(1, 10) AS id,
		concat('User ', generate_series(1, 10)) AS name;

SELECT * FROM users_mview;

-- Combining MATERIALIZED VIEW with TABLE
DROP TABLE IF EXISTS users;
CREATE TABLE
	users
AS
	SELECT
		generate_series(1, 10) AS id,
		concat('User ', generate_series(1, 10)) AS name;

DROP MATERIALIZED VIEW IF EXISTS users_mview;
CREATE MATERIALIZED VIEW users_mview AS SELECT * FROM users;

INSERT INTO users (id, name) VALUES (42, 'John');
SELECT COUNT(*) FROM users_mview; -- 10
REFRESH MATERIALIZED VIEW users_mview;
SELECT COUNT(*) FROM users_mview; -- 11