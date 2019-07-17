require 'net/http'
require 'uri'
require 'date'
require 'octokit'
require 'yaml'

class Ernest
  def run
    settings = YAML.load_file('settings.yaml')
    puts settings['github']
    if settings['github']['api_endpoint']
      Octokit.configure do |c|
        c.api_endpoint = settings['github']['api_endpoint']
      end
    end
    slack_token = settings['slack']['token']
    json = Net::HTTP.get(URI.parse "https://slack.com/api/emoji.list?token=#{slack_token}&pretty=1")

  if false
    ghe_token = settings['github']['ghe_token']
    gist_id = settings['github']['gist_id']

    client = Octokit::Client.new access_token: ghe_token

    save_gist_id = settings['github']['gist_id']
    if
      client.edit_gist(save_gist_id, { "files": {"emoji.json": { content: json }}})
    else
      client.create_gist({ "files": {"emoji.json": { content: json }}})
    end
  end
    date = Date.parse(Time.now.to_s)
    File.open("#{date.to_s}.json", "w", 0755) do |f|
      f.print json
    end
  end

  def format(prev_json,current_json)
    prev_set = Set.new prev["emoji"].keys
    current_set = Set.new current["emoji"].keys
    puts "prev count#{prev_set.count}"
    puts "current count #{current_set.count}"
    diff = current_set - prev_set
    puts "diff count #{diff.count}"
    puts ":"+diff.to_a.join(': :')+":"
  end
end
