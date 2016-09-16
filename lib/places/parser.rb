#AUTHOR: AHMET CALIS
require 'csv'
require 'pry'
require 'uri'
require 'net/http'
require 'json'


# require_relative './category.rb'
# require_relative './location.rb'
# require_relative './place.rb'
# require_relative './version.rb'
# require_relative '../zipcode/zipcode.csv'

class Parser

  def parse(cordinates, zipcode = 10018) #i am the center of the universe
    @zip = zipcode
    #cordinates = cordinate_finder(cordinates)
    url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{cordinates}&radius=1000&types=food&key=???????????"
    uri = URI(url)
    a = Net::HTTP.get(uri)
    @places_hash = JSON.parse(a)
  end

  def list_names_category_address
    @places_hash['results'].map do |a|
      [a['name'], a['types'][0], a['vicinity']]
    #  binding.pry
    end
  end

  def cordinate_finder(zipcode)
    arr = nil
    #CSV.foreach('./lib/zipcode/zipcode.csv') do |row|
    CSV.foreach('./lib/zipcode/zipcode.csv') do |row|
      arr = row if row[0] == "#{zipcode}"
    end
    #binding.pry
    longitude = arr[3]
    latitude = arr[4]
    "#{longitude},#{latitude}"
  end

  def create_new_places
    list_names_category_address.each do |info|
      new_place = Place.new
      new_place.name = info[0]
      new_place.category = Category.find_or_create_by_name(info[1]) #maybe we don't need this line
      #new_place.category = new_category 
      new_place.address = info[2]
      #new_location = Location.find_or_create_by_zip(@zip) 
      #new_location.add_place(new_place)
      #binding.pry
    end
  end
end

# a = Parser.new
# a.parse("10018")
# a.create_new_places
# puts a.list_names_category_address
