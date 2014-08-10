require 'spec_helper'
require 'kind'

describe Kind do
  it 'is initialized with a hash' do
    kind = Kind.new({'name' => 'lion'})
    expect(kind).to be_an_instance_of Kind
  end

  it 'allows manager to access kind name' do
    kind = Kind.new({'name' => 'lion'})
    expect(kind.name).to eq 'lion'
  end

  it 'saves the new kind object to the db' do
    kind = Kind.new({'name' => 'lion'})
    kind.save
    expect(Kind.all).to eq [kind]
  end

  it 'treats an kind object of the same name as the same name' do
    kind = Kind.new({'name' => 'lion'})
    another_kind = Kind.new({'name' => 'lion'})
    expect(kind).to eq another_kind
  end

  it 'adds a animal to a kind' do
    kind = Kind.new({'name' => 'lion'})
    kind.save
    animal = Animal.new({'name' => 'Leo'})
    animal.save
    kind.add_animal(animal)
    results = DB.exec("SELECT * FROM animals WHERE id = #{animal.id}")
    expect(results.first['kind_id']).to eq kind.id
  end

  it 'lists all animals for a kind' do
    animal = Animal.new({'name' => 'Leo'})
    animal.save
    another_animal = Animal.new({'name' => 'Lizzie'})
    another_animal.save
    kind = Kind.new({'name' => 'lion'})
    kind.save
    kind.add_animal(animal)
    kind.add_animal(another_animal)
    expect(kind.list_animals).to eq ['Leo','Lizzie']
  end

  describe '.all' do
    it 'creates kind objects from all kind entries in db' do
      kind = Kind.new({'name' => 'lion'})
      another_kind = Kind.new({'name' => 'tiger'})
      kind.save
      another_kind.save
      expect(Kind.all).to eq [kind, another_kind]
    end  
  end

   describe '.destroy' do
    it 'deletes an kind from the db' do
      kind = Kind.new({'name' => 'lion'})
      another_kind = Kind.new({'name' => 'tiger'})
      kind.save
      another_kind.save
      Kind.destroy(kind)
      expect(Kind.all).to eq [another_kind]
    end
  end

  describe '.find_by_name' do
    it 'finds the kind object by kind name' do
      kind = Kind.new({'name' => 'lion'})
      another_kind = Kind.new({'name' => 'tiger'})
      kind.save
      another_kind.save
      expect(Kind.find_by_name('lion')).to eq kind
    end
  end  
end