require 'pg'

require './lib/database'
require './lib/animal'
require './lib/kind'
require './lib/trainer'

DB = PG.connect({:dbname => 'le_domteur'})

def main_menu
  loop do
    puts "** Training Organizer **\n\n"
    puts "Select 1 to add a trainer\n"
    puts "Select 2 to add an animal\n"
    puts "Select 3 to specify the species of an animal"
    puts "Select 4 to add an animal to a trainer"
    puts "Select 5 to list all trainers\n"
    puts "Select 6 to list all all species trained by a trainer"
    puts "Select 7 to list all all animals trained by a trainer"
    puts "Select 8 to list all animals of a species for a trainer"
    puts "Select * to exit"
  end
  puts "\n"
    print ">"
    user_input = gets.chomp
    case user_input
      when '1' then 
      when '2' then 
      when '3' then 
      when '4' then 
      when '5' then 
      when '6' then
      when '7' then
      when '8' then
      when '*' then exit
    end
  end
end    