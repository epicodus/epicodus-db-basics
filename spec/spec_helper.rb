require 'rspec'
require 'pg'

DB = PG.connect({:dbname => 'le_dompteur_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM animals *;")
    DB.exec("DELETE FROM trainers *;")
  end
end