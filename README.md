Animal Trainer Organizer
=======================

### About
Are you a manager of professional lion tamers and need a means to manage your tamers and animals?  Look no further.  

### Dependencies
*rspec
*postgresql and pg gem

### SET-UP
The structure of the database contains a one to many relationship so that a kind (or species) can have many animals. A many to many relationship also exists so that trainers can have many animals and vice-versa. Follow these guidelines to create the database and tables in postgresql:

*CREATE DATABASE trainer_organizer;
*CREATE TABLE animals (id serial PRIMARY KEY, name varchar);
*CREATE TABLE trainers (id serial PRIMARY KEY, name varchar);
*CREATE TABLE kinds (id serial PRIMARY KEY, name varchar);
*CREATE TABLE lessons (id serial PRIMARY KEY, trainer_id int, animal_id int, kind_id int);
*CREATE TABLE trainer_organizer_test WITH TEMPLATE trainer_organizer;

### Author
Jeff Stringer Copyright :copyright: 2014
