class Database

  def self.all
    all = []
    results = DB.exec("SELECT * FROM #{@table};")
    results.each { |result| all << self.new(result) }
    all
  end

  def self.put_down(object)
    DB.exec("DELETE FROM #{@table} WHERE id = '#{object.id}'")
  end
end
