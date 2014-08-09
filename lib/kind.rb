class Kind < Database

  attr_accessor :name, :id
  @table = 'kinds'

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end

  def save
    result = DB.exec("INSERT INTO kinds (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first['id']
  end

  def ==(another_self)
    self.name == another_self.name
  end
end
