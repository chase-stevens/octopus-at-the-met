# creates a mischevious octopus that grabs eight things from the Met

require 'csv'
require 'time'

# has no backbone lol
class Invertebrate
  attr_reader :backbone

  def initialize
    @backbone = nil
  end
end

# a very specific kind of invertebrate
class Octopus < Invertebrate
  attr_reader :name, :tentacles

  def initialize(name)
    @name = name
    @tentacles = []
    (1..8).each do |x|
      @tentacles.push(Tentacle.new('Tentacle ' + x.to_s))
    end
    puts "#{self.name} the octopus has been born "\
         "and has #{@tentacles.length} tentacles!"
  end
end

# eight of these make most of an octopus
class Tentacle
  attr_reader :name, :thing_held

  def initialize(name)
    @name = name
    @thing_held = nil
  end

  def pick_up(thing)
    @thing_held ||= thing
  end

  def drop
    things.push(@thing_held) if @thing_held
    @thing_held = nil
  end

  def holding?
    if !@thing_held
      puts "#{name} is not holding anything!"
      false
    else
      puts "#{name} is holding #{@thing_held.name}!"
      true
    end
  end
end

# something from the met!
class ArtObject
  attr_reader :name, :maker

  def initialize(name, maker = nil)
    @name = name
    @maker = maker
  end
end

# reading the csv
puts 'Creating Met Objects...'
start_time_met = Time.now
things = []
met_object_arrs = CSV.read('metdata')
end_time_met = Time.now
puts "It took #{end_time_met - start_time_met} seconds to make the art!"

# creating the art objects for the octopus to pick up
until things.size == 8
  object_number = rand(1...met_object_arrs.length)
  next unless met_object_arrs[object_number]
  things.push(ArtObject.new(met_object_arrs[object_number][1]))
end

# the octopus picks up the objects
billy = Octopus.new('Billy')
(0..7).each do |x|
  billy.tentacles[x].pick_up(things[0])
  things.delete(things[0])
  billy.tentacles[x].holding?
end
