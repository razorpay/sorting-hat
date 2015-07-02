require 'sinatra'
require 'clearbit'
require 'clearbit/slack'

Clearbit.key = ENV['CLEARBIT_KEY']

Clearbit::Slack.configure do |config|
  config.slack_url = ENV['SLACK_URL']
  config.slack_channel = ENV['SLACK_CHANNEL']
end

require "./lib/sorting hat"
run Sinatra::Application
