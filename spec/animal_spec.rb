require 'spec_helper'
require 'animal'

describe Animal do
  it 'is initialized with a hash' do
    animal = Animal.new({'name' => 'Leo'})
    expect(animal).to be_an_instance_of Animal
  end

  it 'allows manager to access animal name' do
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

  describe '.all' do
    it 'creates animal objects from all animal entries in db' do
      animal = Animal.new({'name' => 'Leo'})
      another_animal = Animal.new({'name' => 'Leo'})
      animal.save
      another_animal.save
      expect(Animal.all).to eq [animal, another_animal]
    end  
  end
end