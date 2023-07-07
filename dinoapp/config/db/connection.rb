require 'sqlite3'

module DB
  class Connection
    def initialize
      @driver = SQLite3::Database.new('./config/db/dinoapp.db')
    end

    def execute(query)
      @driver.execute(query)
    end
  end
end
