DROP TABLE IF EXISTS books;

SET local total.books = 5000000;

CREATE TABLE books AS
SELECT
	generate_series(
		1,
		current_setting('total.books')::integer
	) AS id,
	concat(
		'Book title: ',
		generate_series(
			1,
			current_setting('total.books')::integer
		)
	) AS title
