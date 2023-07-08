DROP TABLE IF EXISTS users;
CREATE TABLE users (
    alternative_names TEXT,
    classification VARCHAR(20),
    first_name VARCHAR(250),
    frequency_female DECIMAL,
    frequency_male DECIMAL,
    frequency_total DECIMAL,
    frequency_group DECIMAL,
    group_name VARCHAR(250),
    ratio DECIMAL
);

COPY users FROM PROGRAM 'curl "https://data.brasil.io/dataset/genero-nomes/nomes.csv.gz" | gunzip -' CSV HEADER;