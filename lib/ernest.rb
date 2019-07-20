require 'net/http'
require 'uri'
require 'date'
require 'yaml'
require 'slack_client'
require 'gist_client'

class Ernest
  def run
    settings = YAML.load_file('settings.yaml')

    slack_client = SlackClient.new(settings['slack']['token'])
    dump = slack_client.dump_emoji_list

    gist_client = Gist.new(settings['github']['api_endpoint'], settings['github']['access_token'], settings['github']['save_gist_id'])
    last_dump = gist_client.fetch_last

    JSON.parse(last_dump)['files']['emoji_list.json']['content']

    content = dump
    gist_client.save("emoji_list.json", content)
  end
end
