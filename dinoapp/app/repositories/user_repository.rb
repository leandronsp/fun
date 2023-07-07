class UserRepository < BaseRepository
  def self.find_by_email_and_password(email, password)
    query = <<-SQL
      SELECT * FROM users
      WHERE email = '#{email}' AND password = '#{password}'
    SQL

    execute(query)
  end

  def self.find_by_email(email)
    execute("SELECT * FROM users WHERE email = '#{email}'")
  end
end
