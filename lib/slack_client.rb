require 'slack-ruby-client'
class SlackClient
  def initialize(api_token)
    @api_token = api_token
  end

  def dump_emoji_list
    response = Net::HTTP.get(URI.parse "https://slack.com/api/emoji.list?token=#{@api_token}&pretty=1")
  end

  def notify(content, as_user = false)
    client.chat_postMessage(channel: '#feed', text: content, as_user: as_user)
  end

  private

  def client
     client ||= generate_client
  end

  def generate_client
     Slack.configure do |config|
      config.token = @api_token
    end
    Slack::Web::Client.new
  end
end
