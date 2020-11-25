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
puts "-----Destroy Recipes----"
Recipe.destroy_all
puts "-----Destroy Cookbooks----"
Cookbook.destroy_all
puts "-----Destroy Ingredients----"
Ingredient.destroy_all
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
  words: %w[ viande porc boeuf bœuf poulet poule jambon veau lapin lièvre palombe agneau canard canard andouille autruche dinde tournedos steack sauciss rumsteck dindon biche rosette rognons rillettes poularde mouton perdrix paté marcassin joue oie entrecôte grenouille mouton volaille chevreuil chevreau cheval chèvre],
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
user = User.create!(email: 'toto@yahoo.fr', password: 'abcdef', password_confirmation: 'abcdef', first_name: "Georgito", last_name: "Yito", address: "2 Avenue Jean Jaurès, Pont de Choisy, 94600 Choisy-le-Roi")
user1 = User.create!(email: 'toto1@yahoo.fr', password: 'abcdef', password_confirmation: 'abcdef', first_name: "Martin", last_name: "Tran", address: "21 Rue de l'École de Médecine, 75006 Paris")
puts "------ Users fin ----------------"

puts "############## Recipes #################"
puts "------ Recipe omlette -----------------"
omlette = Recipe.create(name: 'Omelette nature', instructions: 'Battez les oeufs à la fourchette, salez et poivrez. Faites chauffer le beurre. Versez les oeufs dans la poêle à feu vif, baissez le feu et laissez cuire doucement en ramenant les bords de l\'omelette au centre au fur et à mesure qu\'ils prennent. Secouez un peu la poêle pour éviter que l\'omelette n\'attache. vérifiez la texture baveuse ou bien prise. Pliez l\'omelette en deux et servez.', difficulty: 'Facile', cooking_time: 15, user_id: user)
puts "------ Recipe raclette ----------------"
raclette = Recipe.create(name: 'Raclette', instructions: 'Laver les pommes de terre, et les faire cuire en robe des champs avec du sel. Pendant que les pommes de terre cuisent, préparer le plat de fromage en coupant des tranches de la grandeur des poêlons. Quand les pommes de terre sont cuites, enclencher l\'appareil à raclette. Chacun fait fondre son fromage dans le poêlon et le déguste ensuite avec une pomme de terre et les accompagnements de son choix.', difficulty: 'facile', cooking_time: 40, user_id: user1)
puts "------ Recipe pommes_sautees -----------------"
pommes_sautees = Recipe.create(name: 'Pommes de terres sautées', instructions: 'Eplucher et laver les pommes de terre, puis les couper en cube. Dans une sauteuse, faire chauffer 3 cuillères à soupe d\'huile. Lorsque l\'huile est chaude, y mettre les pommes de terre d\'un coup. Ajouter sel et poivre. Porter à feu maximal et faire cuire avec le couvercle', difficulty: 'Facile', cooking_time: 20, user_id: user)
puts "------ Recipe roti_de_porc ----------------"
roti_de_porc = Recipe.create(name: 'Rôti de porc aux oignons', instructions: 'Faire dorer le rôti sur chaque face. Réserver. Faire revenir les oignons jusqu\'à qu\'ils blondissent. Saler. Poivrer légèrement. Disposer le rôti sur les oignons. Fermer la cocotte et laisser cuire 1h00 minimum à feu moyen. Servir avec un riz blanc et du fromage râpé.', difficulty: 'Moyen', cooking_time: 60, user_id: user)
puts "------ Recipe crepe ----------------"
crepe = Recipe.create(name: 'Crêpes faciles', instructions: 'Mélanger la farine et l’œuf. Ajouter progressivement le lait et enfin le rhum. Laisser reposer si on a le temps. Mettre une noisette de beurre ou d\'huile sur la poêle et verser peu de pâte pour que les crêpes soient fines. Les laisser cuire et faire le grand saut de la crêpe pour cuire l\'autre côté. Dégustez.', difficulty: 'Facile', cooking_time: 10, user_id: user1)
puts "------ Recipe 6 debut ----------------"
vel_potiron = Recipe.create(name: 'Velouté de potiron', instructions: "Couper la chair du potiron en gros dés. Couper l'oignon et l'ail en lamelles et le faire revenir dans une cocotte avec un peu d'huile. Ajouter les dés de courge dans la cocotte et recouvrir d'eau (juste au niveau de la courge, pas plus). Laisser bouillir environ 45 min à 1 h. Ajouter la crème liquide, saler, poivrer. Mixer.", difficulty: 'Facile', cooking_time: 75, user_id: user1)
puts "------ All Recipes fin ----------------"

puts "############## Doses #################"

puts "----doses recipe vol_potiron---"
potiron = Dose.create(ingredient_id: Ingredient.find_by(name:"Potiron"), quantity:250, unit:"g", recipe_id: vel_potiron)
ail = Dose.create(ingredient_id: Ingredient.find_by(name:"Ail"), quantity:10, unit:"g", recipe_id: vel_potiron)
oignon = Dose.create(ingredient_id: Ingredient.find_by(name:"Oignon"), quantity:50, unit:"g", recipe_id: vel_potiron)

puts "----doses recipe omlette---"
oeufs = Dose.create(ingredient_id: Ingredient.find_by(name:"Oeufs"), quantity:7, unit:"pc", recipe_id: omlette )
beurre = Dose.create(ingredient_id: Ingredient.find_by(name:"Beurre"), quantity:50, unit:"g", recipe_id: omlette)

puts "----doses recipe raclette---"
fromage = Dose.create(ingredient_id: Ingredient.find_by(name:"Fromage à raclette"), quantity:800, unit:"g", recipe_id: raclette )
pommes_de_terre = Dose.create(ingredient_id: Ingredient.find_by(name:"Pomme de terres"), quantity:1000, unit:"g", recipe_id: raclette )

puts "----doses recipe pommes_sautees---"
pommes_de_terre = Dose.create(ingredient_id: Ingredient.find_by(name:"Pomme de terres"), quantity:6, unit:"pc", recipe_id: pommes_sautees )
huile = Dose.create(ingredient_id: Ingredient.find_by(name:"Huile"), quantity:2, unit:"cl", recipe_id: pommes_sautees  )

puts "----All doses fin---"


puts "############## Cookbooks #################"
puts "------ Cookbooks debut -----------------"
cookbook = Cookbook.create!(name: 'Hello', description: 'Awesome beginner starter', user_id: 1)
cookbook1 = Cookbook.create!(name: 'World', description: 'Second best book to have!', user_id: 1)
puts "------ Cookbooks fin ----------------"

puts "############ WEEK ########################"
puts "----------- WEEK DEBUT --------------"
week = Week.create!(user_id: 1, start_day: Date.today)
puts "------------- WEEK FIN -----------------"
p "*************************"
p "****  DB:SEED END !  ****"
p "*************************"
