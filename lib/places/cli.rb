require_relative './category.rb'
require_relative './location.rb'
require_relative './place.rb'
require_relative './place.rb'
require_relative './parser.rb'

class CLI 

  def call
    zipcode = get_the_zipcode
    tmp = Parser.new
    tmp.parse(@cordinates, zipcode)    
    tmp.create_new_places
    
    @categories = Category.all
    @places = Place.all.compact
    list_categories
    puts 'Enter the number of the category you are interested'
    menu
  end

  def get_the_zipcode
    puts 'Please enter a zipcode'

    zipcode = gets.strip
    until valid?(zipcode)
      puts 'Please enter a zipcode'
      zipcode = gets.strip
    end
    zipcode
  end
  
  def valid?(zipcode)
    #check if the zipcode is in the csv file
    
    CSV.foreach('./lib/zipcode/zipcode.csv') do |row|
      if row[0] == "#{zipcode}"
        @cordinates = "#{row[3]},#{row[4]}"
        return true
      end
    end
  end

  def list_categories
    @hash = {}
    Category.all.each.with_index(1) do | val , ind |
      @hash[ind] = val.name
      puts "#{ind}. #{val.name}"
    end
  end

  def list_the_places(category_name) #see this ? it aint accepting a number from 1 - 7
    #Place.all.each do |x|
      #puts x.category if x 

      location = []
    Place.all.each do |x| 
      if x.category.name == @hash[category_name]
       location.push(x) 
      end
    end
    location.each.with_index(1) do |x,v|
      puts "#{v}. #{x.name}"
    end
  end

  def print_the_details(input)
    #binding.pry
  
    puts "details: #{@places[input-1].address}\n "
  end

  def menu
    input = nil
    status = false

    until status == true
      input = digit_or_letter
      
      case input
      when 1..@categories.size #lol just to see
        list_the_places(input)
        puts "Please enter a number to see the details"
        input_2 = digit_or_letter
        case input_2 
        when 1..@places.size 
          print_the_details(input_2)
        end
      when 'list'
        list_categories
      when 'exit'
        status = true
      else
        puts "\nPlease enter a valid command, '1-#{@categories.size}', 'list' or 'exit':"
      end
    end
    goodbye
  end

  def goodbye
    puts "Goodbye"
  end


  def digit_or_letter
    input = gets.strip.downcase
    input.match(/\d+/).to_s.to_i == 0 ? input : input.to_i 
  end
end
CLI.new.call
