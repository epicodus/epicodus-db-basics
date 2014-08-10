class Animal < Database

  attr_accessor :name, :id
  @table = 'animals'

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end

  def kind_id
    result = DB.exec("SELECT * FROM animals WHERE id = #{self.id}")
    result.first['kind_id']
  end

  def save
    result = DB.exec("INSERT INTO animals (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first['id']
  end

  def ==(another_self)
    self.name == another_self.name
  end

  def add_kind(kind)
    results = DB.exec("UPDATE animals SET kind_id = #{kind.id} where id = #{self.id}")
  end

  def add_trainer(trainer)
    results = DB.exec("INSERT INTO lessons (trainer_id, animal_id, kind_id) VALUES (#{trainer.id}, #{self.id}, #{self.kind_id});")
  end
end
