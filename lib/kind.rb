class Kind < Database

  attr_accessor :name, :id
  @table = 'kinds'

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end

  def save
    result = DB.exec("INSERT INTO kinds (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first['id']
  end
  
  def ==(another_self)
    self.name == another_self.name
  end

  def add_animal(animal)
    results = DB.exec("UPDATE animals SET kind_id = #{self.id} where id = #{animal.id}")
  end

  def list_animals
    all_animals = []
    results = DB.exec("SELECT * FROM animals WHERE kind_id = #{self.id}")
    results.each { |result| all_animals << result['name'] }
    all_animals
  end
end
