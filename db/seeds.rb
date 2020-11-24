# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'nokogiri'
require 'pry-byebug'

puts "######################################"
puts "########## SEED - START ##############"
puts "######################################"

puts "########### Destroy #################"
puts "-----Destroy Ingredients----"
Ingredient.destroy_all
puts "-----Destroy User----"
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

puts "######################################"
puts "########## SEED - END ################"
puts "######################################"
