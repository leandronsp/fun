DROP TABLE IF EXISTS geonames CASCADE;
CREATE TABLE geonames (geoname_id integer PRIMARY KEY, name varchar(200), ascii_name TEXT, alternate_names TEXT, latitude float8, longitude float8, feature_class char(1),
feature_code varchar(10), country_code varchar(2), cc2 varchar(200), admin1_code varchar(20), admin2_code varchar(80), admin3_code varchar(20), admin4_code varchar(20), population bigint, elevation
varchar(100), dem varchar(200), timezone varchar(40), modification_date date);

DROP TABLE IF EXISTS admin_codes;
CREATE TABLE admin_codes (code TEXT, name TEXT, ascii_name TEXT, geoname_id integer);

DROP TABLE IF EXISTS feature_codes;
CREATE TABLE feature_codes (code varchar(200), feature_code_description TEXT, feature_class_description TEXT);

DROP TABLE IF EXISTS countries_info;
CREATE TABLE countries_info (isocode varchar(20), isocode3 varchar(20), iso_numeric varchar(10), fips varchar(20), country varchar(200), capital varchar(200), area varchar(50), population bigint,
continent varchar(10), tld varchar(10), currency_code varchar(20), currency_name varchar(50), phone varchar(20), postal_code_format varchar(200), postal_code_regex varchar(300), languages
varchar(100), geoname_id integer, neighbours varchar(80), equivalent_fips_code varchar(50));

COPY admin_codes
FROM PROGRAM 'curl "https://download.geonames.org/export/dump/admin1CodesASCII.txt"'
CSV DELIMITER E'\t';

COPY admin_codes
FROM PROGRAM 'curl "https://download.geonames.org/export/dump/admin2Codes.txt" | tr "\”" " " | tr "\’" " " | tr "\"" " "'
CSV DELIMITER E'\t' ENCODING 'ISO-8859-1';

COPY feature_codes
FROM PROGRAM 'curl "https://download.geonames.org/export/dump/featureCodes_en.txt"'
CSV DELIMITER E'\t';

COPY countries_info
FROM PROGRAM 'curl "https://download.geonames.org/export/dump/countryInfo.txt" | grep -v "^#.*"'
CSV DELIMITER E'\t';

COPY geonames
FROM PROGRAM 'curl "https://download.geonames.org/export/dump/allCountries.zip" | gunzip | tr "\”" " " | tr "\’" " " | tr "\"" " "'
CSV DELIMITER E'\t' ENCODING 'ISO-8859-1';
