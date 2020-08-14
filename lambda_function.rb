require 'dotenv'
require 'net/http'
require 'json/add/core'
require 'jwt'
require './zoom'
require './spread_sheet'
require './slack'

Dotenv.load

def lambda_handler
  join_url = Zoom.reservation_meeting

  daily_person = SpreadSheet.fetch_daily_person

  slack = Slack.new(join_url, daily_person)
  slack.notify
end
