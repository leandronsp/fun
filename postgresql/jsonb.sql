DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200),
    preferences JSONB,
    created_at TIMESTAMP
);

INSERT INTO users (name, preferences, created_at)
VALUES
('Pedro da Silva', '{ "color": "blue" }', NOW()),
('Ana Silva Pereira', '{ "color": "purple" }', NOW())