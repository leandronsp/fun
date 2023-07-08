WITH
users AS (
    SELECT
        substr(gen_random_uuid()::text, 1, 8) AS id,
        'User-' || counter AS name
    FROM
        generate_series(1, 10) AS counter
),
movies AS (
    SELECT
        substr(gen_random_uuid()::text, 1, 8) AS id,
        'Movie-' || counter AS title
    FROM
        generate_series(1, 10) AS counter
),
ratings AS (
    SELECT
        date,
        users.id AS user_id,
        users.name AS user_name,
        movies.id AS movie_id,
        movies.title AS movie_title,
        (random() * 10)::integer as rating
    FROM
        generate_series('2022-07-01'::timestamp, '2022-08-01'::timestamp, '12 hours') AS date,
        users,
        movies
)
SELECT * FROM ratings LIMIT 5;
