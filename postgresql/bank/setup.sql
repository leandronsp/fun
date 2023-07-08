SET local total.users = 200;
SET local total.banks = 20;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id SERIAL,
    name VARCHAR(100),
    email VARCHAR(100)
);
INSERT INTO users (name, email)
SELECT 
    'User ' || id AS name,
    'user.' || id || '@example.com' AS email
FROM
     generate_series(1, current_setting('total.users')::INTEGER) id;

DROP TABLE IF EXISTS banks;
CREATE TABLE banks (
    id SERIAL,
    name VARCHAR(100)
);
INSERT INTO banks (name)
SELECT 
    'Bank ' || id AS name
FROM
     generate_series(1, current_setting('total.banks')::INTEGER) id;
     
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
    id SERIAL,
    user_id INTEGER,
    bank_id INTEGER
);
INSERT INTO accounts (user_id, bank_id)
SELECT 
    user_id,
    bank_id
FROM
     generate_series(1, current_setting('total.users')::INTEGER) user_id,
     generate_series(1, current_setting('total.banks')::INTEGER) bank_id;

DROP TABLE IF EXISTS transfers;
CREATE TABLE transfers (
    source_account_id INTEGER,
    target_account_id INTEGER,
    amount INTEGER
);

INSERT INTO transfers
SELECT 
    source_account_id,
    (random() * (SELECT COUNT(*) FROM accounts))::integer AS target_account_id,
    (random() * 100)::INTEGER AS amount  
FROM
     generate_series(1, (SELECT COUNT(*) FROM accounts)) AS source_account_id;