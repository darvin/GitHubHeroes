require 'time'
require 'octokit'



class GithubFetcher
  def initialize(user_name, user_password)
    @user_name = user_name
    @user_password = user_password
    @client = Octokit::Client.new(:login => user_name, :password => user_password)
  end

  def events_since_time(since_time)
    page = 0
    events = []

    begin
      unfiltered_page_events = @client.user_events(@user_name, {"page"=>page})
      page_events = unfiltered_page_events.find_all do |event|
        Time.iso8601(event.created_at)>since_time
      end
      events += page_events
      page +=1
    end until page_events.empty?
    
    return events
  end

end
