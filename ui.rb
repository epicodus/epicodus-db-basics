require 'pg'

require './lib/database'
require './lib/animal'
require './lib/kind'
require './lib/trainer'

DB = PG.connect({:dbname => 'trainer_organizer'})

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
    puts "Select 8 to list all animals of given species"
    puts "Select * to exit"
    puts "\n"
    print ">"
    user_input = gets.chomp
    case user_input
      when '1' then add_trainer
      when '2' then add_species
      when '3' then add_animal_to_species
      when '4' then add_animal_to_trainer
      when '5' then list_all_trainers
      when '6' then list_all_species_by_trainer
      when '7' then list_all_animals_by_trainer
      when '8' then list_all_animals_of_given_species
      when '*' then exit
    end
  end
end

def add_trainer
  print "New trainer: "; new_trainer = gets.chomp
  Trainer.new({'name' => new_trainer}).save
  puts "*#{new_trainer}* has been added.\n\n"
end

def add_species
  print "New species: "; new_species = gets.chomp
  Kind.new({'name' => new_species}).save
  puts "*#{new_species}* has been added.\n\n"
end

def add_animal_to_species
  puts "Select a species:\n"
  Kind.all.each { |sp| puts sp.name }
  print ">"
  kind_name = gets.chomp
  kind = Kind.find_by_name(kind_name)
  print "New animal to add to #{kind_name} species: "; animal_name = gets.chomp
  new_animal = Animal.new({'name' => animal_name})
  new_animal.save
  kind.add_animal(new_animal)
  puts "*#{new_animal.name}* has been added to #{kind.name} species.\n\n"
end

def add_animal_to_trainer
  puts "Select a trainer:\n"
  Trainer.all.each { |trainer| puts trainer.name }
  print ">"
  trainer_name = gets.chomp
  trainer = Trainer.find_by_name(trainer_name)
  puts "Select a animal:\n"
  Animal.all.each { |animal| puts animal.name }
  print "\nEnter animal name to be added: ";  
  animal_name = gets.chomp
  animal_to_add = Animal.find_by_name(animal_name)
  trainer.add_animal(animal_to_add)
  puts "#{animal_to_add.name} has been added to #{trainer.name}.\n"
end

def list_all_trainers
  Trainer.all.each { |trainer| puts trainer.name }
  puts "\n"
end

def list_all_species_by_trainer
  list_all_trainers
  puts "Select a trainer to view all species:\n"
  print ">"; trainer_name = gets.chomp
  trainer = Trainer.find_by_name(trainer_name)
  puts "All species trained by #{trainer.name}:\n"
  puts trainer.list_kinds
  puts "\n"
end

def list_all_animals_by_trainer
  list_all_trainers
  puts "Select a trainer to view all species:\n"
  print ">"; trainer_name = gets.chomp
  trainer = Trainer.find_by_name(trainer_name)
  puts "All animals trained by #{trainer.name}:\n"
  puts trainer.list_animals
  puts "\n"
end

def list_all_animals_of_given_species
  puts "Select a species:\n"
  Kind.all.each { |sp| puts sp.name }
  print ">"; kind_name = gets.chomp
  kind = Kind.find_by_name(kind_name)
  puts "All animals for #{kind.name}:\n"
  puts kind.list_animals
  puts "\n"
end



main_menu