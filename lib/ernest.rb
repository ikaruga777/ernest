require 'net/http'
require 'uri'
require 'date'
require 'yaml'
require 'slack_client'
require 'gist_client'
require 'emoji_json'

class Ernest
  def run
    settings = YAML.load_file('settings.yaml')

    slack_client = SlackClient.new(settings['slack']['token'])
    gist_client = GistClient.new(settings['github']['api_endpoint'], settings['github']['access_token'], settings['github']['save_gist_id'])

    emoji_dump = slack_client.dump_emoji_list

    last_emoji_dump = gist_client.fetch_last_content "emoji_list.json"
    puts emoji_dump
    puts last_emoji_dump
    emoji_json = EmojiJson.new(JSON.parse(last_emoji_dump), JSON.parse(emoji_dump))
    content = emoji_json.diff
    slack_client.notify(content)

    gist_client.save("emoji_list.json", emoji_dump)
  end
end
