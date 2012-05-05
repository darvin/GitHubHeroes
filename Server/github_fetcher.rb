require 'time'
require 'octokit'

def fetch_events_for_user_since_time(user_name, user_password, since_time)
  client = Octokit::Client.new(:login => user_name, :password => user_password)
  page = 0
  events = []
  while true
    page_events = client.user_events(user_name, {"page"=>page})

    
    page_events.each do |event|
      if Time.iso8601(event.created_at)>since_time
        events << event
      else
        page_events = []
      end
    end
    
    if page_events.empty?
      break
    end
    
    page += 1
  end
  return events
end



since = Time.iso8601("2012-01-28T21:05:03Z")
puts fetch_events_for_user_since_time("darvin", "mustdie", since).count