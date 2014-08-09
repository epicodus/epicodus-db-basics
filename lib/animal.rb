class Animal < Database

  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end  
end