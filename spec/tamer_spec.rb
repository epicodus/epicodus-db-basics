require 'spec_helper'
require 'tamer'

describe Tamer do
  it 'is initialized by a name' do
    tamer = Tamer.new({'name' => 'Billy'})
    expect(tamer).to be_an_instance_of Tamer
  end
end
