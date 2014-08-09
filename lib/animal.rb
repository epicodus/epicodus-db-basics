class Animal < Database

  attr_accessor :species, :id
  @table = 'animals'

  def initialize(attributes)
    @species = attributes['species']
    @id = attributes['id']
  end

  def save
    result = DB.exec("INSERT INTO animals (species) VALUES ('#{@species}') RETURNING id;")
    @id = result.first['id']
  end

  def ==(another_animal)
    self.species == another_animal.species
  end  
end
