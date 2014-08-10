require 'spec_helper'
require 'animal'

describe Animal do
  it 'is initialized with a hash' do
    animal = Animal.new({'name' => 'Leo'})
    expect(animal).to be_an_instance_of Animal
  end

  it 'provides access animal name' do
    animal = Animal.new({'name' => 'Leo'})
    expect(animal.name).to eq 'Leo'
  end

  it 'saves the new animal object to the db' do
    animal = Animal.new({'name' => 'Leo'})
    animal.save
    expect(Animal.all).to eq [animal]
  end
  
  it 'treats an animal object of the same name as the same name' do
    animal = Animal.new({'name' => 'Leo'})
    another_animal = Animal.new({'name' => 'Leo'})
    expect(animal).to eq another_animal
  end

  it 'adds a kind to an animal' do
    kind = Kind.new({'name' => 'lion'})
    kind.save
    animal = Animal.new({'name' => 'Leo'})
    animal.save
    animal.add_kind(kind)
    results = DB.exec("SELECT * FROM animals WHERE id = #{animal.id}")
    expect(results.first['kind_id']).to eq kind.id
  end 

  it 'provides access to kind_id after kind added to animal' do
    animal = Animal.new({'name' => 'Leo'})
    animal.save
    kind = Kind.new({'name' => 'lion'})
    kind.save
    animal.add_kind(kind)
    results = DB.exec("SELECT * FROM animals WHERE id = #{animal.id}")
    expect(results.first['kind_id']).to eq animal.kind_id
  end

  it 'adds a trainer to an animal' do
    tamer = Trainer.new({'name' => 'Ricky Bobby'})
    tamer.save
    animal = Animal.new({'name' => 'Leo'})
    animal.save
    kind = Kind.new({'name' => 'lion'})
    kind.save
    kind.add_animal(animal)
    animal.add_trainer(tamer)
    results = DB.exec("SELECT * FROM lessons WHERE trainer_id = #{tamer.id}")
    expect(results.first['kind_id']).to eq kind.id
  end 

  describe '.all' do
    it 'creates animal objects from all animal entries in db' do
      animal = Animal.new({'name' => 'Leo'})
      another_animal = Animal.new({'name' => 'Leo'})
      animal.save
      another_animal.save
      expect(Animal.all).to eq [animal, another_animal]
    end  
  end

  describe '.destroy' do
    it 'deletes an animal from the db' do
      animal = Animal.new({'name' => 'Leo'})
      another_animal = Animal.new({'name' => 'Leo'})
      animal.save
      another_animal.save
      Animal.destroy(animal)
      expect(Animal.all).to eq [another_animal]
    end
  end

  describe '.find_by_name' do
    it 'finds the animal object by animal name' do
      animal = Animal.new({'name' => 'Leo'})
      another_animal = Animal.new({'name' => 'Lizzie'})
      animal.save
      another_animal.save
      expect(Animal.find_by_name('Lizzie')).to eq another_animal
    end
  end  
end