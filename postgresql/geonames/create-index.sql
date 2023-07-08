CREATE EXTENSION IF NOT EXISTS pg_trgm;
DROP INDEX IF EXISTS geonames_search_idx;
CREATE INDEX geonames_search_idx ON geonames USING GIN (to_tsvector('simple', name || ' ' || alternate_names));