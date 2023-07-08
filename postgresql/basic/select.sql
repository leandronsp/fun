-- SELECT values
SELECT
	1,
	'John';

-- SELECT with labels
SELECT
	1 AS id,
	'John' AS name;

-- SELECT with built-in function
SELECT
	gen_random_uuid() AS id,
	'John' AS name;
