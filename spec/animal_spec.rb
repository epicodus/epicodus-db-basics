require 'spec_helper'
require 'animal'

describe Animal do
  it 'is initialized with a hash' do
    animal = Animal.new({'name' => "lion"})
    expect(animal).to be_an_instance_of Animal
  end
end