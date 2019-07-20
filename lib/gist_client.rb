require 'octokit'
class GistClient
  def initialize(api_endpoint, token, gist_id)
    @api_endpoint = api_endpoint
    @token = token
    @gist_id = gist_id
  end

  def save(file, content)
    if @gist_id
      client.edit_gist(@gist_id,
        {
          "files": {
            file => {
              content: content
            }
          }
        }
      )
    else
      gist = client.create_gist(
        {
          "files": {
            file => {
              content: content
            }
          }
        }
      )
      @gist_id = gist['id']
      gist
    end
  end

  def fetch_last
    gist = client.gist(@gist_id)
    last_commit_url = gist['history'].first['url']
    Net::HTTP.get(URI.parse last_commit_url)
  end

  private

  def client
    client ||= generate_client
  end

  def generate_client
    Octokit.configure do |c|
      c.api_endpoint = @api_endpoint
    end
    Octokit::Client.new access_token: @token
  end
end