require 'spec_helper'
require 'animal'

describe Animal do
  it 'is initialized with a hash' do
    animal = Animal.new({'species' => 'lion'})
    expect(animal).to be_an_instance_of Animal
  end

  it 'saves the new animal object to the db' do
    animal = Animal.new({'species' => 'lion'})
    animal.save
    expect(Animal.all).to eq [animal]
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
end