# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.delete_all
# Recipe.delete_all
# Cookbook.delete_all


p "*************************"
p "***  DB:SEED START !  ***"
p "*************************"
p "-------------"
p "Users creation"
user = User.create!(email: 'toto@yahoo.fr', password: 'abcdef', password_confirmation: 'abcdef', first_name: "Georgito", last_name: "Yito", address: "2 Avenue Jean Jaurès, Pont de Choisy, 94600 Choisy-le-Roi")
user1 = User.create!(email: 'toto1@yahoo.fr', password: 'abcdef', password_confirmation: 'abcdef', first_name: "Martin", last_name: "Tran", address: "21 Rue de l'École de Médecine, 75006 Paris")
p "-------------"
p "Recipes creation"
recipe = Recipe.create!(name: 'Omelette', instructions: 'Cassez 2 oeufs et puis YOLO!! Filler filler filler filler filler filler filler filler filler filler filler filler YOOOOOooooooooolooooooooooooooooooooooooooooooooooooooo', difficulty: 'Facile', cooking_time: 5, user_id: 1)
recipe1 = Recipe.create!(name: 'OmeletteBis', instructions: 'Cassez 2 oeufs et puis YOLO!! Filler filler filler filler filler filler filler filler filler filler filler filler YOOOOOooooooooolooooooooooooooooooooooooooooooooooooooo', difficulty: 'Facile', cooking_time: 5, user_id: 1)
p "-------------"
p "Cookbooks creation"
cookbook = Cookbook.create!(name: 'Hello', description: 'Awesome beginner starter', user_id: 1)
cookbook1 = Cookbook.create!(name: 'World', description: 'Second best book to have!', user_id: 1)
p "-------------"
p "*************************"
p "****  DB:SEED END !  ****"
p "*************************"
