require 'pg'

require './lib/database'
require './lib/animal'
require './lib/kind'
require './lib/trainer'

DB = PG.connect({:dbname => 'le_dompteur'})

def main_menu
  loop do
    puts "** Training Organizer **\n\n"
    puts "Select 1 to add a trainer"
    puts "Select 2 to add a new species of animal to be trained"
    puts "Select 3 to add an animal to a specific species"
    puts "Select 4 to add an animal to a trainer"
    puts "Select 5 to list all trainers"
    puts "Select 6 to list all all species trained by a trainer"
    puts "Select 7 to list all all animals trained by a trainer"
    puts "Select 8 to list all animals of a species for a trainer"
    puts "Select * to exit"
    puts "\n"
    print ">"
    user_input = gets.chomp
    case user_input
      when '1' then add_trainer
      when '2' then add_species
      when '3' then add_animal
      when '*' then exit
    end
  end
end

def add_trainer
  print "New trainer: "; new_trainer = gets.chomp
  Trainer.new(new_trainer).save
  puts "*#{new_trainer}* has been added.\n\n"
end

def add_species
  print "New species: "; new_species = gets.chomp
  Kind.new(new_species).save
  puts "*#{new_species}* has been added.\n\n"
end

def add_animal
  print "New animal: "; new_animal = gets.chomp
  Animal.new(new_animal).save
  puts "*#{new_animal}* has been added.\n\n"
end



main_menu