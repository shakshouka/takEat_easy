# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or create!d alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)
# User.delete_all
# Recipe.delete_all
# Cookbook.delete_all

require 'open-uri'
require 'nokogiri'

puts "######################################"
puts "########## SEED - START ##############"
puts "######################################"

puts "########### Destroy #################"

puts "-----Destroy Grocery-item----"
GroceryItem.destroy_all

puts "-----Destroy Grocery-list----"
GroceryList.destroy_all

puts "-----Destroy Meal----"
Meal.destroy_all

puts "-----Destroy Dose----"
Dose.destroy_all

puts "-----Destroy CookbookRecipes----"
CookbookRecipe.destroy_all

puts "-----Destroy Ingredient----"
Ingredient.destroy_all

puts "-----Destroy Week----"
Week.destroy_all

puts "-----Destroy Recipe----"
Recipe.destroy_all

puts "-----Destroy Cookbook----"
Cookbook.destroy_all

puts "-----Destroy User----"
User.destroy_all

puts "----------------------------------"
puts "######### Ingredients ################"
puts "---Ingredients noms debut---------"

RESTRICTIONS  = [
  {name: "gluten",
  words: %w[ abadèche ble seigle orge avoine epeautre kamut pain abadèche ]
  },
  {name: "Crustaces",
  words: %w[ crevette crabe langouste langoustine homard ecrevisse tourteau ]
  },
  {name: "Œuf",
  words: %w[ œuf oeuf ],
  exceptions: %w[ boeuf bœuf ]
  },
  {name: "Poisson",
  words: %w[ saumon truite poisson turbot thon sardine maquereau surimi sole sandre oursin espadon colin cabillaud lieu]
  },
  {name: "Arachides",
  words: %w[ arachide ]
  },
  {name: "Soja",
  words: %w[ soja ]
  },
  {name: "Lait",
  words: %w[ lait yaourt fromage vache raclette neuchâtel neufchâtel gruyère crème beurre],
  exceptions: %w[ soja noisette vegetal vegetal vegetal vegetal avoine coco brebis amande marron mûre truffe bananes balsamique anchois cacahuète]
  },
  {name: "Fruits à coque",
  words: %w[ amande noisette noix cajou pecan pistache macadamia ]
  },
  {name: "Celeri",
  words: %w[ celeri ]
  },
  {name: "Moutarde",
  words: %w[ moutarde ]
  },
  {name: "Graines de sesame",
  words: %w[ sesame tahini tahine ]
  },
  {name: "Lupin",
  words: %w[ lupin lupins ]
  },
  {name: "Mollusques",
  words: %w[ escargot huître moules palourde coquille "Saint Jacques" calamars poulpe seiche ]
  },
  {name: "Porc",
  words: %w[ porc jambon cochon andouille sauciss rosette rillettes marcassin ]
  },
  {name: "Non Vegan",
  words: %w[ viande porc boeuf bœuf poulet poule jambon veau lapin lièvre palombe agneau canard canard andouille autruche dinde tournedos steack sauciss rumsteck dindon biche rosette rognons rillettes poularde mouton perdrix pate marcassin joue oie entrecôte grenouille mouton volaille chevreuil chevreau cheval chèvre farce faux-filet],
  exceptions: %w[ fromage ]
  },
  {name: "Alcool",
  words: %w[ rhum alcool amaretto anisette triple porto liqueur ]
  },
]

def restrictions(ingredient)
  list_of_restrictions = []

  RESTRICTIONS.each do |restriction|
    if word?(restriction, ingredient)
      if restriction.has_key?(:exceptions)
        if !exception?(restriction, ingredient)
          list_of_restrictions << restriction[:name]
        end
      else
          list_of_restrictions << restriction[:name]
      end
    end
    return list_of_restrictions
  end
  # puts "#{ingredient} - #{list_of_restrictions}"
end

def word?(restriction, ingredient)
  restriction[:words].each do |word|
    return true if ingredient.match?(/#{word}/)
  end
  return false
end

def exception?(restriction, ingredient)
  restriction[:exceptions].each do |exception|
    return true if ingredient.match?(/#{exception}/)
  end
  return false
end

# restrictions("viande des grisons")
count = 0

("a".."z").each do |letter|
  puts letter
  (1..13).each do |page_num| # (1..13)
    url = "https://www.marmiton.org/recettes/index/ingredient/#{letter}/#{page_num}"

    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('.index-item-card').each do |element|
      text = element.search('.index-item-card-name')
      ingredient_name = text.text.strip.downcase
      list_of_restrictions = restrictions(ingredient_name)
      Ingredient.create!(name: ingredient_name, list_of_restrictions: list_of_restrictions)
      count += 1
      # img = element.search('img')
      # ingredient_img = img.attr('src').value
    end
  end
end
puts "#{count} Ingredients crees !"
puts "------ Ingredients fin --------"

# Users
puts "############## Users #################"
puts "------ Users debut -----------------"
puts user = User.create!(email: 'toto@yahoo.fr', password: 'abcdef', password_confirmation: 'abcdef', first_name: "Georgito", last_name: "Yito", address: "2 Avenue Jean Jaurès, Pont de Choisy, 94600 Choisy-le-Roi", list_of_restrictions:["porc", "soja"], num_of_members:1)
puts user1 = User.create!(email: 'toto1@yahoo.fr', password: 'abcdef', password_confirmation: 'abcdef', first_name: "Martin", last_name: "Tran", address: "21 Rue de l'ecole de Medecine, 75006 Paris")
puts user666 = User.create!(email: 'diablo@yahoo.fr', password: 'abcdef', password_confirmation: 'abcdef', first_name: "Lucie", last_name: "Fer", address: "User qui sert juste pour les recipe vides")
puts "------ Users fin ----------------"

puts "############## Recipes #################"
puts "------ Empty Recipe -----------------"
puts empty = Recipe.create!(name: 'EMPTY', instructions: "Ceci est une recette vide, vous n'êtes pas sensé la voir. J'espère que ca fait trente caractères.", difficulty: 'Facile', cooking_time: 666, user_id: user666.id)

puts "------ Recipe omelette -----------------"

puts omelette = Recipe.create!(name: 'Omelette nature', instructions: 'Battez les oeufs à la fourchette, salez et poivrez. Faites chauffer le beurre. Versez les oeufs dans la poêle à feu vif, baissez le feu et laissez cuire doucement en ramenant les bords de l\'omelette au centre au fur et à mesure qu\'ils prennent. Secouez un peu la poêle pour eviter que l\'omelette n\'attache. verifiez la texture baveuse ou bien prise. Pliez l\'omelette en deux et servez.', difficulty: 'Facile', cooking_time: 15, user_id: user.id)
puts "----doses recipe omelette---"
puts oeufs = Dose.create!(ingredient_id: Ingredient.find_by(name:"oeuf").id, quantity:3, unit:"pc", recipe_id: omelette.id )
puts beurre = Dose.create!(ingredient_id: Ingredient.find_by(name:"beurre").id, quantity:20, unit:"g", recipe_id: omelette.id )

puts "------ Recipe raclette ----------------"
p raclette = Recipe.create!(name: 'Raclette', instructions: 'Laver les pommes de terre, et les faire cuire en robe des champs avec du sel. Pendant que les pommes de terre cuisent, preparer le plat de fromage en coupant des tranches de la grandeur des poêlons. Quand les pommes de terre sont cuites, enclencher l\'appareil à raclette. Chacun fait fondre son fromage dans le poêlon et le deguste ensuite avec une pomme de terre et les accompagnements de son choix.', difficulty: 'Facile', cooking_time: 40, user_id: user.id)
puts "----doses recipe raclette---"

puts fromage = Dose.create!(ingredient_id: Ingredient.find_by(name:"fromage à raclette").id, quantity:100, unit:"g", recipe_id: raclette.id )
puts pommes_de_terre = Dose.create!(ingredient_id: Ingredient.find_by(name:"pomme de terre").id, quantity:200, unit:"g", recipe_id: raclette.id )

puts "------ Recipe pommes_sautees -----------------"
puts pommes_sautees = Recipe.create!(name: "Pommes de terres sautees", instructions: "Eplucher et laver les pommes de terre, puis les couper en cube. Dans une sauteuse, faire chauffer 3 cuillères à soupe d'huile. Lorsque l'huile est chaude, y mettre les pommes de terre d'un coup. Ajouter sel et poivre. Porter à feu maximal et faire cuire avec le couvercle", difficulty: "Facile", cooking_time: 20, user_id: user.id)
puts "----doses recipe pommes_sautees---"
puts pommes_de_terre = Dose.create!(ingredient_id: Ingredient.find_by(name:"pomme de terre").id, quantity:200, unit:"g", recipe_id: pommes_sautees.id )
puts huile = Dose.create!(ingredient_id: Ingredient.find_by(name:"huile").id, quantity:2, unit:"cl", recipe_id: pommes_sautees.id  )

puts "--- Recipes rot_porc debut --------"
rot_porc = Recipe.create!(name: 'Roti de porc aux oignons', instructions: 'Faire dorer le rôti sur chaque face. Reserver. Faire revenir les oignons jusqu\'à qu\'ils blondissent. Saler. Poivrer legèrement. Disposer le rôti sur les oignons. Fermer la cocotte et laisser cuire 1h00 minimum à feu moyen. Servir avec un riz blanc et du fromage râpe.', difficulty: 'Moyen', cooking_time: 70, user_id: user.id)
puts "----doses.create!---"
puts rotiporc = Dose.create!(ingredient_id: Ingredient.find_by(name:"rôti de porc").id, quantity:150, unit:"g", recipe_id: rot_porc.id)
puts oignon = Dose.create!(ingredient_id: Ingredient.find_by(name:"oignon").id, quantity:50, unit:"g", recipe_id: rot_porc.id)
puts riz = Dose.create!(ingredient_id: Ingredient.find_by(name:"riz thaï").id, quantity:100, unit:"g", recipe_id: rot_porc.id)
puts from = Dose.create!(ingredient_id: Ingredient.find_by(name:"fromage râpé").id, quantity:30, unit:"g", recipe_id: rot_porc.id)
puts "---- Recipes rot_porc fin ---------"

puts "------ Recipe crepe ----------------"
puts crepes = Recipe.create!(name: 'Crepes faciles', instructions: "Melanger la farine et l'œuf. Ajouter progressivement le lait et enfin le rhum. Laisser reposer si on a le temps. Mettre une noisette de beurre ou d\'huile sur la poêle et verser peu de pâte pour que les crêpes soient fines. Les laisser cuire et faire le grand saut de la crêpe pour cuire l\'autre côte. Degustez.", difficulty: 'Facile', cooking_time: 10, user_id: user1.id)
puts "----doses.create!----"
puts farine = Dose.create!(ingredient_id: Ingredient.find_by(name:"farine de blé noir").id, quantity:90, unit:"g", recipe_id: crepes.id)
puts oeuf = Dose.create!(ingredient_id: Ingredient.find_by(name:"oeuf").id, quantity:1, unit:"pc", recipe_id: crepes.id)
puts lait = Dose.create!(ingredient_id: Ingredient.find_by(name:"lait demi-écrémé").id, quantity:20, unit:"cl", recipe_id: crepes.id)
puts beurre = Dose.create!(ingredient_id: Ingredient.find_by(name:"beurre demi-sel").id, quantity:5, unit:"g", recipe_id: crepes.id)
puts rhum = Dose.create!(ingredient_id: Ingredient.find_by(name:"rhum").id, quantity:4, unit:"cl", recipe_id: crepes.id)
puts "------ Recipe crepes fin ------"

puts "--- Recipes vel_potiron debut --------"
puts "----vel_pot recipe.create!---"
puts vel_potiron = Recipe.create!(name: 'Veloute de potiron', instructions: "Couper la chair du potiron en gros des. Couper l'oignon et l'ail en lamelles et le faire revenir dans une cocotte avec un peu d'huile. Ajouter les des de courge dans la cocotte et recouvrir d'eau (juste au niveau de la courge, pas plus). Laisser bouillir environ 45 min à 1 h. Ajouter la crème liquide, saler, poivrer. Mixer.", difficulty: 'Difficile', cooking_time: 75, user_id: user.id)
puts "----doses.create!---"
puts potiron = Dose.create!(ingredient_id: Ingredient.find_by(name:"potiron").id, quantity:250, unit:"g", recipe_id: vel_potiron.id)
puts ail = Dose.create!(ingredient_id: Ingredient.find_by(name:"ail").id, quantity:10, unit:"g", recipe_id: vel_potiron.id)
puts oignon = Dose.create!(ingredient_id: Ingredient.find_by(name:"oignon").id, quantity:50, unit:"g", recipe_id: vel_potiron.id)
puts "---- Recipes vel_potiron fin ---------"

puts "------ Recipe puree de carottes debut ----------------"
puts pur_carottes = Recipe.create!(name: 'Puree de carottes', instructions: "Eplucher les legumes et les couper en morceaux assez gros. Mettre à cuire environ 10 à 15 min dans une cocotte minute. Une fois cuits, mettre les legumes dans le bol du mixeur avec la crème fraiche et le beurre. Assaisonner selon votre convenance. Mixer le tout jusqu'à l'obtention d'une puree lisse. Servir chaud.", difficulty: 'Moyen', cooking_time: 25, user_id: user.id)
puts "-doses.create!-"
puts pdt = Dose.create!(ingredient_id: Ingredient.find_by(name:"pomme de terre").id, quantity:5, unit:"g", recipe_id: pur_carottes.id)
puts carottes = Dose.create!(ingredient_id: Ingredient.find_by(name:"carotte").id, quantity:2, unit:"pc", recipe_id: pur_carottes.id)
puts beurre = Dose.create!(ingredient_id: Ingredient.find_by(name:"beurre").id, quantity:10, unit:"g", recipe_id: pur_carottes.id)
puts creme = Dose.create!(ingredient_id: Ingredient.find_by(name:"crème fraîche épaisse").id, quantity:10, unit:"cl", recipe_id: pur_carottes.id)
puts "------ Recipe puree de carottes fin ------"

puts "------ Recipes fin ----------------"
puts "############ WEEK ########################"
puts "----------- WEEK DEBUT --------------"
puts week = Week.create!(user_id: user.id, start_day: Date.new(2020,11,21))
puts "------------- WEEK FIN -----------------"

puts "############## Meals #################"
puts "------ Meals debut -----------------"
puts Meal.create!(week_id:week.id, recipe_id:pur_carottes.id, moment:"déjeuner", day: (week.start_day + 0).strftime('%a %d %b %Y'), num_of_members: 3 )
puts Meal.create!(week_id:week.id, recipe_id:omelette.id, moment:"diner", day: (week.start_day + 0).strftime('%a %d %b %Y'), num_of_members: 3 )
puts Meal.create!(week_id:week.id, recipe_id:crepes.id, moment:"diner", day: (week.start_day + 1).strftime('%a %d %b %Y'), num_of_members: 3 )
puts Meal.create!(week_id:week.id, recipe_id:rot_porc.id, moment:"diner", day: (week.start_day + 2).strftime('%a %d %b %Y'), num_of_members: 3 )
puts Meal.create!(week_id:week.id, recipe_id:pommes_sautees.id, moment:"diner", day: (week.start_day + 3).strftime('%a %d %b %Y'), num_of_members: 3 )
puts Meal.create!(week_id:week.id, recipe_id:pommes_sautees.id, moment:"déjeuner", day: (week.start_day + 3).strftime('%a %d %b %Y'), num_of_members: 3 )
puts Meal.create!(week_id:week.id, recipe_id:raclette.id, moment:"déjeuner", day: (week.start_day + 4).strftime('%a %d %b %Y'), num_of_members: 3 )
puts Meal.create!(week_id:week.id, recipe_id:omelette.id, moment:"déjeuner", day: (week.start_day + 5).strftime('%a %d %b %Y'), num_of_members: 3 )
puts Meal.create!(week_id:week.id, recipe_id:crepes.id, moment:"diner", day: (week.start_day + 5).strftime('%a %d %b %Y'), num_of_members: 3 )
puts Meal.create!(week_id:week.id, recipe_id:vel_potiron.id, moment:"diner", day: (week.start_day + 6).strftime('%a %d %b %Y'), num_of_members: 3 )
puts "------ Meals fin -----------------"

puts "############## Grocery_list #################"
puts "------ Grocery_list debut -----------------"
grocery_list = GroceryList.new(week_id: week.id)
puts "------ Grocery_list fin -----------------"

puts "############## Grocery_items #################"
puts "------ Grocery_items debut -----------------"
potiron = GroceryItem.new(grocery_list_id: grocery_list.id, total_quantity: 1000, unit: "g", ingredient_id: Ingredient.find_by(name:"Potiron") )
beurre = GroceryItem.new(grocery_list_id: grocery_list.id, total_quantity: 1000, unit: "g", ingredient_id: Ingredient.find_by(name:"Beurre") )
farine = GroceryItem.new(grocery_list_id: grocery_list.id, total_quantity: 1000, unit: "g", ingredient_id: Ingredient.find_by(name:"Farine") )
oeuf = GroceryItem.new(grocery_list_id: grocery_list.id, total_quantity: 1000, unit: "pc", ingredient_id: Ingredient.find_by(name:"Oeuf") )
lait = GroceryItem.new(grocery_list_id: grocery_list.id, total_quantity: 200, unit: "cl", ingredient_id: Ingredient.find_by(name:"Oeuf") )
puts "------ Grocery_items fin -----------------"

puts "############## Cookbooks #################"
puts "------ Cookbooks debut -----------------"
puts cookbook = Cookbook.create!(name: 'Favoris', description: 'Favorites recipes!', user_id: user.id)
puts "------ Cookbooks fin ----------------"

puts "############## Cookbook-recipes #################"
puts "------ Cookbook-recipes debut -----------------"

puts cbkrcp = CookbookRecipe.create!(cookbook_id: 1, recipe_id: 1)
puts cbkrcp2 = CookbookRecipe.create!(cookbook_id: 1, recipe_id: 2)
puts cbkrcp3 = CookbookRecipe.create!(cookbook_id: 1, recipe_id: 3)

puts cbkrcp4 = CookbookRecipe.create!(cookbook_id: 1, recipe_id: 4)
puts "------ Cookbook-recipes fin -----------------"

p "*************************"
p "****  DB:SEED END !  ****"
p "*************************"
