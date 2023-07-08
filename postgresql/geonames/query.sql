  SELECT
    DISTINCT(geonames.geoname_id),
    geonames.name,
    geonames.feature_class,
    geonames.feature_code,
    geonames.country_code,
    geonames.admin1_code,
    geonames.admin2_code,
    geonames.population,
    geonames.timezone,
    feature_codes.feature_class_description,
    feature_codes.feature_code_description,
    admin_codes.name AS admin_code_name,
    countries_info.country,
    SIMILARITY(geonames.feature_code, 'PPLA') * SIMILARITY(geonames.feature_code, 'PPLC') * log(COALESCE(NULLIF(geonames.population, 0), 1)) AS rank_score
  FROM
    geonames
  JOIN
    feature_codes ON feature_codes.code = geonames.feature_class || '.' || geonames.feature_code
  LEFT JOIN
    admin_codes ON admin_codes.code = geonames.country_code || '.' || geonames.admin1_code
  JOIN
    countries_info ON countries_info.isocode = geonames.country_code
  WHERE
    to_tsvector('simple', geonames.name || ' ' || geonames.alternate_names) @@ plainto_tsquery('simple', 'londres')
  ORDER BY
    rank_score DESC
  LIMIT 5