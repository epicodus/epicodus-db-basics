class Trainer < Database

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

  def ==(another_self)
    self.name == another_self.name
  end

  def add_animal(animal)
    results = DB.exec("INSERT INTO lessons (trainer_id, animal_id, kind_id) VALUES (#{self.id}, #{animal.id}, #{animal.kind_id});")
  end

  def list_kinds
    all_kinds = []
    results = DB.exec("SELECT kinds.* FROM
                      trainers JOIN lessons ON (trainers.id = lessons.trainer_id)
                               JOIN kinds ON (lessons.kind_id = kinds.id)
                      where trainers.id = #{self.id};")
    results.each { |result| all_kinds << result['name'] }
    all_kinds
  end
end
