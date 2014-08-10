require 'rspec'
require 'pg'
require 'database'

DB = PG.connect({:dbname => 'le_dompteur_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM kinds *;")
    DB.exec("DELETE FROM trainers *;")
    DB.exec("DELETE FROM animals *;")
    DB.exec("DELETE FROM lessons *;")
  end
end