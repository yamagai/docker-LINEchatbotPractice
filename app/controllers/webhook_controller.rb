require 'open-uri'

class WebhookController < ApplicationController

  def callback
    body = request.body.read
    events = client.parse_events_from(body)
    messageId = events[0]["message"]["id"]

    client = Line::Bot::Client.new { |config|
    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
    response = client.get_message_content(messageId)

    output_path = '/app_name/tmp/images/file.jpg'

    File.open(output_path, 'w+b') do |fp|
      fp.write(response.body)
    end
    
  end
end
