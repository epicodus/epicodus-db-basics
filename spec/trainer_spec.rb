require 'spec_helper'
require 'trainer'

describe Trainer do
  it 'is initialized by a name' do
    tamer = Trainer.new({'name' => 'Billy'})
    expect(tamer).to be_an_instance_of Trainer
  end

  it 'allows manager to access Tamer name' do
    tamer = Trainer.new({'name' => 'Billy'})
    expect(tamer.name).to eq 'Billy'
  end

  it 'saves the new tamer object to the db' do
    tamer = Trainer.new({'name' => 'Billy'})
    tamer.save
    expect(Trainer.all).to eq [tamer]
  end

  it 'treats a tamer object of the same name as the same name' do
    tamer = Trainer.new({'name' => 'Ricky Bobby'})
    another_tamer = Trainer.new({'name' => 'Ricky Bobby'})
    expect(tamer).to eq another_tamer
  end

  it 'adds an animal to a trainer' do
    tamer = Trainer.new({'name' => 'Ricky Bobby'})
    tamer.save
    animal = Animal.new({'name' => 'Leo'})
    animal.save
    kind = Kind.new({'name' => 'lion'})
    kind.save
    animal.add_kind(kind)
    tamer.add_animal(animal)
    results = DB.exec("SELECT * FROM lessons WHERE trainer_id = #{tamer.id}")
    expect(results.first['kind_id']).to eq kind.id.to_s
  end

  it 'adds multiple animals of the same kind' do
    tamer = Trainer.new({'name' => 'Ricky Bobby'})
    tamer.save
    animal = Animal.new({'name' => 'Leo'})
    animal.save
    kind = Kind.new({'name' => 'lion'})
    kind.save
    another_animal = Animal.new({'name' => 'Lizzie'})
    another_animal.save
    animal.add_kind(kind)
    another_animal.add_kind(kind)
    tamer.add_animal(animal)
    tamer.add_animal(another_animal)
    results = DB.exec("SELECT * FROM lessons WHERE trainer_id = #{tamer.id}")
    expect(results[0]['kind_id']).to eq results[1]['kind_id']
  end

  describe '.all' do
    it 'creates tamer objects from all tamer entries in db' do
      tamer = Trainer.new({'name' => 'Ricky Bobby'})
      another_tamer = Trainer.new({'name' => 'Ricky Bobby'})
      tamer.save
      another_tamer.save
      expect(Trainer.all).to eq [tamer, another_tamer]
    end  
  end

  it 'deletes an tamer from the db' do
    tamer = Trainer.new({'name' => 'Bobby'})
    another_tamer = Trainer.new({'name' => "little Bobby"})
    tamer.save
    another_tamer.save
    Trainer.destroy(tamer)
    expect(Trainer.all).to eq [another_tamer]
  end

  # describe 'list_kinds' do
  #   it 'returns all kinds of animals trained by trainer' do
  #     tamer = Trainer.new({'name' => 'Ricky Bobby'})
  #     tamer.save
  #     animal = Animal.new({'name' => 'Leo'})
  #     animal.save
  #     another_animal = Animal.new({'name' => 'Fozzie'})
  #     another_animal.save
  #     kind = Kind.new({'name' => 'lion'})
  #     kind.save
  #     another_kind = Kind.new({'name' => 'bear'})
  #     another_kind.save
  #     animal.add_kind(kind)
  #     another_animal.add_kind(another_kind)
  #     tamer.add_animal(animal)
  #     tamer.add_animal(another_animal)
  #     results = DB.exec("SELECT * FROM lessons")
  #     results.each { |result| puts result  }
  #     expect(tamer.list_kinds).to eq ['lion', 'bear']
  #   end  
  # end  
end
