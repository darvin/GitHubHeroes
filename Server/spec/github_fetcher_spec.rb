require 'github_fetcher'

require 'date'
require 'time'
describe GithubFetcher do
  it "should return more events on earlier date" do
    fetcher = GithubFetcher.new("darvin", "mustdie")
    first = fetcher.events_since_time(Time.parse((DateTime.now-4).to_s)).count
    second = fetcher.events_since_time(Time.parse((DateTime.now-10).to_s)).count
    first.should be < second
    second.should be > 0
  end
end