require 'spec_helper'
require 'animal'

describe Animal do
  it 'is initialized with a hash' do
    animal = Animal.new({'species' => 'lion'})
    expect(animal).to be_an_instance_of Animal
  end

  it 'allows manager to access animal species' do
    animal = Animal.new({'species' => 'lion'})
    expect(animal.species).to eq 'lion'
  end

  it 'saves the new animal object to the db' do
    animal = Animal.new({'species' => 'lion'})
    animal.save
    expect(Animal.all).to eq [animal]
  end

  it 'treats an animal object of the same species as the same species' do
    animal = Animal.new({'species' => 'lion'})
    another_animal = animal = Animal.new({'species' => 'tiger'})
    expect(animal).to eq another_animal
  end  

  describe '.all' do
    it 'creates animal objects from all animal entries in db' do
      animal = Animal.new({'species' => 'lion'})
      another_animal = animal = Animal.new({'species' => 'tiger'})
      animal.save
      another_animal.save
      expect(Animal.all).to eq [animal, another_animal]
    end  
  end

  it 'deletes an animal from the db' do
    animal = Animal.new({'species' => 'lion'})
    another_animal = animal = Animal.new({'species' => 'tiger'})
    animal.save
    another_animal.save
    Animal.destroy(animal)
    expect(Animal.all).to eq [another_animal]
  end
end