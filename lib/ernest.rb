# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'date'
require 'yaml'
require 'slack_client'
require 'gist_client'
require 'emoji_json'
require 'ernest/version'

module Ernest
  class Error < StandardError; end

  def run
    settings = YAML.load_file('settings.yaml')

    slack_client = SlackClient.new(settings['slack']['token'])
    gist_client = GistClient.new(settings['github']['api_endpoint'], settings['github']['access_token'], settings['github']['save_gist_id'])

    emoji_dump = slack_client.dump_emoji_list
    last_emoji_dump = gist_client.fetch_last_content(settings['github']['save_gist_file'])

    if last_emoji_dump

      emoji_json = EmojiJson.new(JSON.parse(last_emoji_dump), JSON.parse(emoji_dump))
      content = emoji_json.diff
      puts settings['slack']['notify_channel']

      slack_client.notify(settings['slack']['notify_channel'], content)
    end

    gist_client.save(settings['github']['save_gist_file'], emoji_dump)
  end
end
