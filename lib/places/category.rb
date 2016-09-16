class Category
  attr_accessor :name, :places, :location
  #type can be, eg restaurant, pharmacy, etc

  @@all = []
  def initialize(name)
    @places = []
    @name = name
  end
  
  def save
    @@all << self
  end

  def self.create(name)
    new(name).tap {|a| a.save}
  end

  def self.find_by_name(name)
    self.all.detect {|x| x.name == name}
  end

  def self.find_or_create_by_name(name) #place is an object
    self.find_by_name(name) || self.create(name)
  end

  def self.all
    @@all
  end

  def self.show_categories
    @@all.each {|category| puts category.type}
  end

  def show_places
    @places.each {|place| puts place.name}
  end
end
