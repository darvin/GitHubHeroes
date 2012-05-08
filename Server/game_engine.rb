
:iron
:gold
:stone


class SummableHash < Hash
  def initialize(hash={})
    super(hash)
    self.default = 0
  end
  def +(another_hash)
    result = SummableHash.new
    Set.new(self.keys+another_hash.keys).each { |key|
      result[key] = self[key]+another_hash[key]
    }
    return result
  end
  def -(another_hash)
    result = SummableHash.new
    Set.new(self.keys+another_hash.keys).each { |key|
      r = self[key]+another_hash[key]
      r = 0 if r < 0
      result[key] = r
    }
    return result
  end
  
  
end

class CreatureType
  attr_reader :name, :level, :faction, :mineral_cost
  def initialize(name, faction, level, mineral_cost)
    @name = name
    @level = level
    @faction = faction
    @faction.add_creature_type(self)
    @mineral_cost = mineral_cost
  end
  
  def raising_cost
    return {
      1=>0.1,
      2=>1.1,
      3=>3,
      4=>7,
      5=>12,
      6=>21,
      7=>34,
      8=>121,
      }[@level]
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


class Action
  attr_reader :type, :event, :time
  attr_accessor :result, :text 
  def initialize(github_event)
    @type = github_event.type
    @event = github_event
    @time = Time.iso8601(event.created_at)
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
  
  def perform_github_events(github_events)
    github_events.each do |event|
      action = Action.new(event)
      self.perform_action(action)
    end
  end
  
  def perform_action(action)
    
    result = self.send("action_"+action.type, action)
    if result
      action.comment = result["comment"]
      action.result = result["result"]
    end
    #write action
    
  end
  
  def action_PushEvent(action)
  end
  
  def action_CommitCommentEvent(action)
  end
  
  def action_FollowEvent(action)
  end
  
  def action_IssuesEvent(action)
  end
  
  def action_GollumEvent(action)
  end
  
  def action_CreateEvent(action)
  end
  
  def action_WatchEvent(action)
  end
  
  def action_IssueCommentEvent(action)
  end
  
  def action_MemberEvent(action)
  end
  
  def action_GistEvent(action)
  end
  
  def action_CommitCommentEvent(action)
  end
  
  # def action_(action)
  # end

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
  
  def each_creature_type
    @creature_types.values.each { |creature_type|
      yield creature_type
    }
  end
  
  
end



class City
  attr_reader :name, :faction, :hero, :creatures, :creatures_hired
  def initialize( name, faction, hero=nil, parent_city=nil,  creatures=SummableHash.new, creatures_hired = SummableHash.new)
    @parent_city = parent_city
    @name = name
    @hero = hero
    @faction = faction
    @creatures = creatures
    @creatures_hired = creatures_hired
  end
  
  def raise_creatures_for_straight(straight)
    additional_creatures = SummableHash.new
    @faction.each_creature_type { |creature_type|
      additional_creatures[creature_type] = straight/creature_type.raising_cost
    }
    @creatures += additional_creatures
    
  end
  
  def hire_all_creatures
  end
  
  def attack_city(city)
  end
  
  
end

