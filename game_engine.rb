
:iron
:gold
:stone

class CreatureType
  attr_reader :name, :level, :faction, :mineral_cost
  def initialize(name, faction, level, mineral_cost)
    @name = name
    @level = level
    @faction = faction
    @faction.add_creature_type(self)
    @mineral_cost = mineral_cost
  end
  
end

class Creature
  def initialize(creature_type)
    @creature_type = creature_type
    
  end
  
  def level
    return @creature_type.level
  end
  
end

class HeroType
  attr_reader :name
  def initialize(name)
    @name = name
  end
  
  
end

class Hero
  attr_reader :name
  def initialize(name, hero_type, params, cities=[], minerals={})
    @name = name
    @hero_type = hero_type
    @cities = cities
    @params = params
    @minerals = minerals
  end
  def add_minerals_for_straight(straight)
  end
  
  def pay_minerals(minerals)
  end
  def gain_expirience(xp)
    
  end

end

class Faction
  attr_reader :name
  def initialize(name)
    @name = name
    @creature_types = {}
    @starting_heroes = []
  end
  
  def add_creature_type(creature_type)
    @creature_types[creature_type.level] = creature_type
  end
  
  def creature_for_level(creature_level)
    return @creature_types[creature_level]
  end
  
  
end

class City
  attr_reader :name, :faction, :hero
  def initialize(name, faction, hero=nil,  creatures=[], creatures_hired = [])
    @name = name
    @hero = hero
    @creatures = creatures
    @creatures_hired = creatures_hired
  end
  
  def raise_creatures_for_straight(straight)
  end
  
  def hire_all_creatures
  end
  
end

class CityOutpost < City
  def initialize(city, hero, creatures=[], creatures_hired = [])
    super("#{hero.name} outpost of #{city.name}", city.faction, hero, creatures, creatures_hired)
    @city_to_attack = city
  end
  
  def attack_city
  end
  
end


hero = Hero.new("darvin", [], {:iron=>3, :gold=>4})
puts hero.inspect
desert = Faction.new("Desert")
goblin = CreatureType.new("Goblin", desert, 1, {:iron=>1})
puts desert.inspect
puts goblin.inspect

gonduras = City.new("Gonduras", desert)
gonduras_outpost = CityOutpost.new(gonduras, hero)

puts gonduras.inspect
puts gonduras_outpost.inspect