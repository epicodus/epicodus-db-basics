require 'spec_helper'
require 'tamer'

describe Tamer do
  it 'is initialized by a name' do
    tamer = Tamer.new({'name' => 'Billy'})
    expect(tamer).to be_an_instance_of Tamer
  end

  it 'allows manager to access Tamer name' do
    tamer = Tamer.new({'name' => 'Billy'})
    expect(tamer.name).to eq 'Billy'
  end


  it 'saves the new animal object to the db' do
    tamer = Tamer.new({'name' => 'Billy'})
    tamer.save
    expect(Tamer.all).to eq [tamer]
  end
end
