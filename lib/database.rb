class Database

  def self.all
    all = []
    results = DB.exec("SELECT * FROM #{@table};")
    results.each { |result| all << self.new(result) }
    all
  end

  def self.destroy(object)
    DB.exec("DELETE FROM #{@table} WHERE id = '#{object.id}'")
  end

  def self.find_by_name(name)
    self.all.find { |object| name == object.name } 
  end 
end
