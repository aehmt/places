#require_relative '../lib/concerns/findable'

class Location 
  attr_accessor :zip, :places 
  @@all = []
  def initialize(zip)
    @zip = zip
    @places = [] 
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.places
    all.map do |location|
      location.places
    end
  end

  def self.create(zip)
    new(zip).tap {|a| a.save}
  end

  def self.find_by_zip(zip)
    self.all.detect {|x| x.zip == zip}
  end

  def self.find_or_create_by_zip(zip)
    self.find_by_zip(zip) || self.create(zip)
  end

  def add_place(place)
    place.location = self if !place.location
    @places << place if !place.location.places.include?(place)
  end
end
