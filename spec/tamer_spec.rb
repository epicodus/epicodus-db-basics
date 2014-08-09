require 'spec_helper'
require 'tamer'

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
end
