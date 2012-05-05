
:iron
:gold
:stone


class SummableHash < Hash
  
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
  
  
end



class City
  attr_reader :name, :faction, :hero, :creatures, :creatures_hired
  def initialize( name, faction, hero=nil, parent_city=nil,  creatures={}, creatures_hired = {})
    @parent_city = parent_city
    @name = name
    @hero = hero
    @creatures = creatures
    @creatures_hired = creatures_hired
  end
  
  def raise_creatures_for_straight(straight)
  end
  
  def hire_all_creatures
  end
  
  def attack_city(city)
  end
  
  
end

