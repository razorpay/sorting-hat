require 'pp'
require 'json'

def validate(params)
  unless params.has_key? 'name'
    msg="Name not provided"
  end

  unless params['email'] =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    msg="Invalid Email Address"
  end
  if msg
    status 400
    body msg
    return false
  else
    return true
  end
end

post '/' do

  unless validate(params)
    return false
  end

  first_name, last_name = FullNameSplitter.split(params['name'])

  # Get data from clearbit
  begin
    clearbit_response = Clearbit::Streaming::PersonCompany(email: params['email'])
  rescue Exception => e
    status 503
    body "Error in clearbit configuration or API"
    return
  end

  # Merge it with the data that we had
  clearbit_response.merge!(
    email: params['email'],
    given_name: first_name,
    family_name: last_name
    message: "New Signup",
  )

  # Send it to slack
  slack_response = Clearbit::Slack.ping(clearbit_response)
  unless slack_response.kind_of? Net::HTTPSuccess
    status 502
    body 'Slack returned an error'
    return
  end

  # And if everything went right
  status 204
end

get '/' do
  "Sorting Hat"
end