SELECT
    users.name AS username,
    banks.name AS bank,
	SUM(CASE
		WHEN accounts.id = transfers.source_account_id
			THEN transfers.amount * -1
		WHEN accounts.id = transfers.target_account_id
			THEN transfers.amount
		ELSE
			0.00
		END)
	AS balance
FROM
    users
JOIN accounts ON accounts.user_id = users.id
JOIN banks ON banks.id = accounts.bank_idq
LEFT JOIN transfers ON
    transfers.source_account_id = accounts.id
    OR transfers.target_account_id = accounts.id
GROUP BY users.name, banks.name
ORDER BY username ASC, balance ASC
