WITH
accounts_idx AS(
    SELECT
        accounts.id AS account_id,
        users.name AS username,
        banks.name AS bank
    FROM accounts
    JOIN users ON users.id = accounts.user_id
    JOIN banks ON banks.id = accounts.bank_id
),
accounts_from AS (
    SELECT
        idx.username,
        idx.bank,
        SUM(transfers.amount * -1) AS balance
    FROM transfers
    JOIN accounts_idx idx ON idx.account_id = transfers.source_account_id
    GROUP BY idx.username, idx.bank
),
accounts_to AS (
    SELECT
        idx.username,
        idx.bank,
        SUM(transfers.amount) AS balance
    FROM transfers
    JOIN accounts_idx idx ON idx.account_id = transfers.target_account_id
    GROUP BY idx.username, idx.bank
),
results AS (
    SELECT * FROM accounts_from
    UNION
    SELECT * FROM accounts_to
)
SELECT
    username,
    bank,
    SUM(balance) AS balance
FROM results
GROUP BY username, bank
ORDER BY username ASC, balance ASC
