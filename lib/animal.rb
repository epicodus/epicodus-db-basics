class Animal

  attr_accessor :species, :id

  def initialize(attributes)
    @species = attributes['species']
    @id = attributes['id']
  end

  def save
    result = DB.exec("INSERT INTO animals (species) VALUES ('#{@species}') RETURNING id;")
    @id = result.first['id']
  end

  def self.all
    animals = []
    results = DB.exec("SELECT * FROM animals;")
    results.each { |result| animals << Animal.new(result) }
    animals  
  end
end