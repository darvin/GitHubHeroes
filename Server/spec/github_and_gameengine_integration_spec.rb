require 'game_engine'
require 'github_fetcher'
require 'date'
require 'time'


describe Hero do
  it "should perform actions from fetched github events" do
    fetcher = GithubFetcher.new("darvin", "mustdie")
    events = fetcher.events_since_time(Time.parse((DateTime.now-3).to_s))
    hero = Hero.new("Darvin", nil, nil)
    hero.perform_github_events(events)
     
  end
  
end