class Database

  def self.all
    all = []
    results = DB.exec("SELECT * FROM #{@table};")
    results.each { |result| all << self.new(result) }
    all
  end
end