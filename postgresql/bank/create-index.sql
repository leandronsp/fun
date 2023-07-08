DROP INDEX IF EXISTS transfers_in, transfers_out;

CREATE INDEX transfers_in ON transfers (target_account_id);
CREATE INDEX transfers_out ON transfers (source_account_id);
