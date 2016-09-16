class Place
  attr_accessor :name, :address, :phone, :website, :location
  attr_reader :category

  @@all = []
  def initialize
    @@all << self
  end

  def category= (category)
    @category = category
    @category.places << self
  end

  def self.all
    @@all
  end

  def self.show_info(input)
    choice = @@all.detect {|place| place.name == input}
    puts "Name: #{choice.name}"
    puts "Address: #{choice.name}"
    puts "Phone: #{choice.phone}"
    puts "Website: #{choice.website}"
  end
end
