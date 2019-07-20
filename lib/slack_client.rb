class SlackClient
  def initialize(api_token)
    @api_token = api_token
  end

  def dump_emoji_list
    response = Net::HTTP.get(URI.parse "https://slack.com/api/emoji.list?token=#{@api_token}&pretty=1")
  end

  def notify

  end
end
