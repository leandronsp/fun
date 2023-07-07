require './config/db/connection'

connection = DB::Connection.new

connection.execute <<-SQL
  DROP TABLE IF EXISTS users
SQL

connection.execute <<-SQL
  CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email VARCHAR(100),
    password VARCHAR(100)
  )
SQL

connection.execute <<-SQL
  INSERT INTO users
    (email, password)
    VALUES
    ('user@example.com', 'user'),
    ('admin@example.com', 'admin')
SQL

puts connection.execute("SELECT * FROM users")
