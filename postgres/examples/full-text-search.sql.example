WITH constants AS (SELECT 'sales' AS querystr)

SELECT
  courses.id,
  courses.title,
  courses.description,
  rank_title,
  rank_description
FROM
  courses,
  constants,
  NULLIF(ts_rank(setweight(to_tsvector(COALESCE(courses.title, '')), 'A'), plainto_tsquery(constants.querystr)), 0) rank_title,
  NULLIF(ts_rank(setweight(to_tsvector(COALESCE(courses.description, '')), 'B'), plainto_tsquery(constants.querystr)), 0) rank_description
WHERE
  to_tsvector(COALESCE(courses.title, '')) || to_tsvector(COALESCE(courses.description, ''))
  @@ plainto_tsquery(constants.querystr)
ORDER BY rank_title, rank_description DESC NULLS LAST
LIMIT 10 OFFSET 0
