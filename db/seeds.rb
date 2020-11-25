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

require 'open-uri'
require 'nokogiri'

puts "######################################"
puts "########## SEED - START ##############"
puts "######################################"

puts "########### Destroy #################"
puts "-----Destroy Ingredients----"
Ingredient.destroy_all

puts "-----Destroy Meal----"
Meal.destroy_all

puts "-----Destroy CookbookRecipes----"
CookbookRecipe.destroy_all

puts "-----Destroy Grocery-item----"
GroceryItem.destroy_all

puts "-----Destroy Recipes----"
Recipe.destroy_all

puts "-----Destroy Doses----"
Dose.destroy_all

puts "-----Destroy Cookbooks----"
Cookbook.destroy_all

puts "-----Destroy Week----"
Week.destroy_all

puts "-----Destroy Grocery-list----"
GroceryList.destroy_all

puts "-----Destroy Users----"
User.destroy_all

puts "----------------------------------"

# Ingredients
puts "######### Ingredients ################"
puts "---Ingrédients noms debut---------"

RESTRICTIONS  = [
  {name: "gluten",
  words: %w[ abadèche blé seigle orge avoine épeautre kamut pain abadèche ]
  },
  {name: "Crustacés",
  words: %w[ crevette crabe langouste langoustine homard écrevisse tourteau ]
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
  exceptions: %w[ soja noisette vegetal végétal végetal vegétal avoine coco brebis amande marron mûre truffe bananes balsamique anchois cacahuète]
  },
  {name: "Fruits à coque",
  words: %w[ amande noisette noix cajou pécan pistache macadamia ]
  },
  {name: "Céleri",
  words: %w[ celeri ]
  },
  {name: "Moutarde",
  words: %w[ moutarde ]
  },
  {name: "Graines de sésame",
  words: %w[ sésame tahini tahiné ]
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
  words: %w[ viande porc boeuf bœuf poulet poule jambon veau lapin lièvre palombe agneau canard canard andouille autruche dinde tournedos steack sauciss rumsteck dindon biche rosette rognons rillettes poularde mouton perdrix paté marcassin joue oie entrecôte grenouille mouton volaille chevreuil chevreau cheval chèvre farce faux-filet],
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
      ingredient_name = text.text.strip
      list_of_restrictions = restrictions(ingredient_name)
      Ingredient.create(name: ingredient_name, list_of_restrictions: list_of_restrictions)
      count += 1
      # img = element.search('img')
      # ingredient_img = img.attr('src').value
    end
  end
end
puts "#{count} Ingrédients crées !"
puts "------ Ingrédients fin --------"

# Users
puts "############## Users #################"
puts "------ Users debut -----------------"
puts user = User.create!(email: 'toto@yahoo.fr', password: 'abcdef', password_confirmation: 'abcdef', first_name: "Georgito", last_name: "Yito", address: "2 Avenue Jean Jaurès, Pont de Choisy, 94600 Choisy-le-Roi")
puts user1 = User.create!(email: 'toto1@yahoo.fr', password: 'abcdef', password_confirmation: 'abcdef', first_name: "Martin", last_name: "Tran", address: "21 Rue de l'École de Médecine, 75006 Paris")
puts "------ Users fin ----------------"

puts "############## Recipes #################"
puts "------ Recipe omelette -----------------"
puts omelette = Recipe.create(name: 'Omelette nature', instructions: 'Battez les oeufs à la fourchette, salez et poivrez. Faites chauffer le beurre. Versez les oeufs dans la poêle à feu vif, baissez le feu et laissez cuire doucement en ramenant les bords de l\'omelette au centre au fur et à mesure qu\'ils prennent. Secouez un peu la poêle pour éviter que l\'omelette n\'attache. vérifiez la texture baveuse ou bien prise. Pliez l\'omelette en deux et servez.', difficulty: 'Facile', cooking_time: 15, user_id: user)
puts "----doses recipe omelette---"
puts oeufs = Dose.create(ingredient_id: Ingredient.find_by(name:"Oeufs"), quantity:7, unit:"pc", recipe_id: omelette )
puts beurre = Dose.create(ingredient_id: Ingredient.find_by(name:"Beurre"), quantity:50, unit:"g", recipe_id: omelette)

puts "------ Recipe raclette ----------------"
raclette = Recipe.create(name: 'Raclette', instructions: 'Laver les pommes de terre, et les faire cuire en robe des champs avec du sel. Pendant que les pommes de terre cuisent, préparer le plat de fromage en coupant des tranches de la grandeur des poêlons. Quand les pommes de terre sont cuites, enclencher l\'appareil à raclette. Chacun fait fondre son fromage dans le poêlon et le déguste ensuite avec une pomme de terre et les accompagnements de son choix.', difficulty: 'facile', cooking_time: 40, user_id: user1)
puts "----doses recipe raclette---"
puts fromage = Dose.create(ingredient_id: Ingredient.find_by(name:"Fromage à raclette"), quantity:800, unit:"g", recipe_id: raclette )
puts pommes_de_terre = Dose.create(ingredient_id: Ingredient.find_by(name:"Pomme de terres"), quantity:1000, unit:"g", recipe_id: raclette )

puts "------ Recipe pommes_sautees -----------------"
puts pommes_sautees = Recipe.create(name: 'Pommes de terres sautées', instructions: 'Eplucher et laver les pommes de terre, puis les couper en cube. Dans une sauteuse, faire chauffer 3 cuillères à soupe d\'huile. Lorsque l\'huile est chaude, y mettre les pommes de terre d\'un coup. Ajouter sel et poivre. Porter à feu maximal et faire cuire avec le couvercle', difficulty: 'Facile', cooking_time: 20, user_id: user)
puts "----doses recipe pommes_sautees---"
puts pommes_de_terre = Dose.create(ingredient_id: Ingredient.find_by(name:"Pomme de terres"), quantity:6, unit:"pc", recipe_id: pommes_sautees )
puts huile = Dose.create(ingredient_id: Ingredient.find_by(name:"Huile"), quantity:2, unit:"cl", recipe_id: pommes_sautees  )

puts "--- Recipes rot_porc debut --------"
rot_porc = Recipe.create(name: 'Rôti de porc aux oignons', instructions: 'Faire dorer le rôti sur chaque face. Réserver. Faire revenir les oignons jusqu\'à qu\'ils blondissent. Saler. Poivrer légèrement. Disposer le rôti sur les oignons. Fermer la cocotte et laisser cuire 1h00 minimum à feu moyen. Servir avec un riz blanc et du fromage râpé.', difficulty: 'Moyen', cooking_time: 70, user_id: user1)
puts "----doses.create---"
puts rotiporc = Dose.create(ingredient_id: Ingredient.find_by(name:"Rôti de porc"), quantity:150, unit:"g", recipe_id: rot_porc)
puts oignon = Dose.create(ingredient_id: Ingredient.find_by(name:"Oignon"), quantity:50, unit:"g", recipe_id: rot_porc)
puts riz = Dose.create(ingredient_id: Ingredient.find_by(name:"Riz thaï"), quantity:100, unit:"g", recipe_id: rot_porc)
puts from = Dose.create(ingredient_id: Ingredient.find_by(name:"Fromage râpé"), quantity:30, unit:"g", recipe_id: rot_porc)
puts "---- Recipes rot_porc fin ---------"

puts "------ Recipe crepe ----------------"
puts crepes = Recipe.create(name: 'Crêpes faciles', instructions: "Mélanger la farine et l'œuf. Ajouter progressivement le lait et enfin le rhum. Laisser reposer si on a le temps. Mettre une noisette de beurre ou d\'huile sur la poêle et verser peu de pâte pour que les crêpes soient fines. Les laisser cuire et faire le grand saut de la crêpe pour cuire l\'autre côté. Dégustez.", difficulty: 'Facile', cooking_time: 10, user_id: user1)
puts "----doses.create----"
puts farine = Dose.create(ingredient_id: Ingredient.find_by(name:"Farine de blé noir"), quantity:90, unit:"g", recipe_id: crepes)
puts oeuf = Dose.create(ingredient_id: Ingredient.find_by(name:"Oeuf"), quantity:1, unit:"pc", recipe_id: crepes)
puts lait = Dose.create(ingredient_id: Ingredient.find_by(name:"Lait demi-écrémé"), quantity:20, unit:"cl", recipe_id: crepes)
puts beurre = Dose.create(ingredient_id: Ingredient.find_by(name:"Beurre demi-sel"), quantity:5, unit:"g", recipe_id: crepes)
puts rhum = Dose.create(ingredient_id: Ingredient.find_by(name:"Rhum"), quantity:4, unit:"cl", recipe_id: crepes)
puts "------ Recipe crepes fin ------"

puts "--- Recipes vel_potiron debut --------"
puts "----vel_pot recipe.create---"
puts vel_potiron = Recipe.create(name: 'Velouté de potiron', instructions: "Couper la chair du potiron en gros dés. Couper l'oignon et l'ail en lamelles et le faire revenir dans une cocotte avec un peu d'huile. Ajouter les dés de courge dans la cocotte et recouvrir d'eau (juste au niveau de la courge, pas plus). Laisser bouillir environ 45 min à 1 h. Ajouter la crème liquide, saler, poivrer. Mixer.", difficulty: 'Facile', cooking_time: 75, user_id: user)
puts "----doses.create---"
puts potiron = Dose.create(ingredient_id: Ingredient.find_by(name:"Potiron"), quantity:250, unit:"g", recipe_id: vel_potiron)
puts ail = Dose.create(ingredient_id: Ingredient.find_by(name:"Ail"), quantity:10, unit:"g", recipe_id: vel_potiron)
puts oignon = Dose.create(ingredient_id: Ingredient.find_by(name:"Oignon"), quantity:50, unit:"g", recipe_id: vel_potiron)
puts "---- Recipes vel_potiron fin ---------"

puts "------ Recipe puree de carottes debut ----------------"
puts pur_carottes = Recipe.create(name: 'Purée de carottes', instructions: "Eplucher les légumes et les couper en morceaux assez gros. Mettre à cuire environ 10 à 15 min dans une cocotte minute. Une fois cuits, mettre les légumes dans le bol du mixeur avec la crème fraiche et le beurre. Assaisonner selon votre convenance. Mixer le tout jusqu'à l'obtention d'une purée lisse. Servir chaud.", difficulty: 'Moyen', cooking_time: 25, user_id: user)
puts "-doses.create-"
puts beurre = Dose.create(ingredient_id: Ingredient.find_by(name:"Pomme de terre"), quantity:5, unit:"g", recipe_id: pur_carottes)
puts carottes = Dose.create(ingredient_id: Ingredient.find_by(name:"Carotte"), quantity:2, unit:"pc", recipe_id: pur_carottes)
puts pdt = Dose.create(ingredient_id: Ingredient.find_by(name:"Carotte"), quantity:2, unit:"pc", recipe_id: pur_carottes)
puts creme = Dose.create(ingredient_id: Ingredient.find_by(name:"Crème fraîche épaisse"), quantity:10, unit:"cl", recipe_id: pur_carottes)
puts "------ Recipe puree de carottes fin ------"

puts "------ Recipes fin ----------------"
puts "############ WEEK ########################"
puts "----------- WEEK DEBUT --------------"
puts week = Week.create(user_id: user, start_day: Date.today)
puts "------------- WEEK FIN -----------------"
p "*************************"
p "****  DB:SEED END !  ****"
p "*************************"

puts "############## Meals #################"
puts "------ Meals debut -----------------"
puts Meal.create(week_id:week, recipe_id:pur_carottes, moment:"", day: week.start_day + 0, num_of_members: 3 )
puts Meal.create(week_id:week, recipe_id:crepes, moment:"", day: week.start_day + 1, num_of_members: 3 )
puts Meal.create(week_id:week, recipe_id:rot_porc, moment:"", day: week.start_day + 2, num_of_members: 3 )
puts Meal.create(week_id:week, recipe_id:pommes_sautees, moment:"", day: week.start_day + 3, num_of_members: 3 )
puts Meal.create(week_id:week, recipe_id:raclettte, moment:"", day: week.start_day + 4, num_of_members: 3 )
puts Meal.create(week_id:week, recipe_id:omelette, moment:"", day: week.start_day + 5, num_of_members: 3 )
puts Meal.create(week_id:week, recipe_id:vel_potiron, moment:"", day: week.start_day + 6, num_of_members: 3 )
puts "------ Meals fin -----------------"

puts "############## Grocery_list #################"
puts "------ Grocery_list debut -----------------"
grocery_list = GroceryList.new(week_id: week)
puts "------ Grocery_list fin -----------------"

puts "############## Grocery_items #################"
puts "------ Grocery_items debut -----------------"
potiron = GroceryItem.new(grocery_list: grocery_list, total_quantity: 2, ingredient_id: Ingredient.find_by(name:"Potiron") )
puts "------ Grocery_items fin -----------------"

puts "############## Cookbooks #################"
puts "------ Cookbooks debut -----------------"
puts cookbook = Cookbook.create(name: 'Hello', description: 'Awesome beginner starter', user_id: user)
puts cookbook1 = Cookbook.create(name: 'World', description: 'Second best book to have!', user_id: user)
puts "------ Cookbooks fin ----------------"

puts "############## Cookbook-recipes #################"
puts "------ Cookbook-recipes debut -----------------"
puts "To come..."
puts "------ Cookbook-recipes fin -----------------"