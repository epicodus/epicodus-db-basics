class Tamer < Database

  attr_accessor :name, :id
  @table = 'trainers'

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end

  def save
    result = DB.exec("INSERT INTO trainers (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first['id']
  end

  def ==(another_tamer)
    self.name == another_tamer.name
  end  

end