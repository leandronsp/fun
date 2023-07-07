class BaseRepository
  def self.connection
    DB::Connection.new
  end

  def self.execute(query)
    connection.execute(query)
  end
end
