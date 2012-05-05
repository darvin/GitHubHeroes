require 'game_engine'





describe City do
  before do
    @faction = Faction.new("Default faction")
    @creature_level_1 = CreatureType.new("Creature level1", @faction, 1, {:iron=>1, :gold=>2})
    @creature_level_2 = CreatureType.new("Creature level2", @faction, 2, {:iron=>3, :gold=>5})
    @city = City.new("Default city", @faction)
  end
  it "should raise creatures depend on straight" do
    @city.raise_creatures_for_straight(1)
    @city.creatures_hired.should have(0).items    
    @city.creatures.should include(@creature_level_1)
    @city.creatures.should_not include(@creatures_level_2)
  
  end
  
end


describe SummableHash do
  before(:each) do
    @faction = Faction.new("Default faction")
    @creature_level_1 = CreatureType.new("Creature level1", @faction, 1, {:iron=>1, :gold=>2})
    @creature_level_2 = CreatureType.new("Creature level2", @faction, 2, {:iron=>3, :gold=>5})
    @creature_level_3 = CreatureType.new("Creature level3", @faction, 3, {:iron=>3, :gold=>5})
    @h1 = SummableHash.new
    @h2 = SummableHash.new({@creature_level_2=>2, @creature_level_1=>4})
    @h3 = SummableHash.new({@creature_level_2=>3, @creature_level_1=>5})
    @h4 = SummableHash.new({@creature_level_2=>10, @creature_level_1=>5})
    @h5 = SummableHash.new({@creature_level_3=>10, @creature_level_1=>5})
    
  end
  it "should correctly sum hashes" do
    h2andh3 = @h2+@h3
    h2andh3.should eq(SummableHash.new({@creature_level_2=>5, @creature_level_1=>9}))
  end
  
  it "should correctly diff hashes" do
    h3minush2 = @h3-@h2
    h3minush2.should eq(SummableHash.new({@creature_level_2=>1, @creature_level_1=>1}))
  end
  
  it "should still always positive when it diffs hashes" do
    h2minush3 = @h2-@h3
    h2minush3.should eq(SummableHash.new({}))
    h4minush3 = @h4-@h3
    h4minush3.should eq(SummableHash.new({@creature_level_2=>7}))
  end
  
  it "should merge keys correctly" do
    h = @h4 +@h5
    h.should eq(SummableHash.new({@creature_level_1=>10, @creature_level_2=>10,@creature_level_3=>10}))
  end
  
  
  
end

