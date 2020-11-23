# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'nokogiri'

puts "######################################"
puts "########## SEED - START ##############"
puts "######################################"

# Ingredients

("a".."z").each do |letter| 
  url = "https://www.marmiton.org/recettes/index/ingredient/#{letter}"

  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)

  html_doc.search('.index-item-card').each do |element|
    text = element.search('.index-item-card-name')
    puts text.text.strip
    img = element.search('img')
    p img.attr('src').value
  end
end
