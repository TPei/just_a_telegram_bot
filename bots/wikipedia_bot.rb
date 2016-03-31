require 'rest-client'

class WikipediaBot
  def initialize(args)
  end

  def check
    url = 'http://en.wikipedia.org/w/api.php?action=query&list=random&rnlimit=5&format=json'
    response = JSON.parse(RestClient::Request.execute(:url => url, :method => :get, :verify_ssl => false))
  end
end
