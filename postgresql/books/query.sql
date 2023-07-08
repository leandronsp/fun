-- DROP INDEX IF EXISTS books_idx;
-- CREATE INDEX books_idx ON books (id);

EXPLAIN SELECT title 
FROM books
WHERE id = 123