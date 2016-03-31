require 'rest-client'

class WikipediaBot
  def initialize(args)
  end

  def check
    url = 'https://en.wikipedia.org/wiki/Special:Random'
    final_url = ''
    RestClient.get(:url => url, :verify_ssl => false) do |response, request, result, &block|
      if [301, 302, 307].include? response.code
        response.follow_redirection(request, result, &block)
      end
      final_url = request.url
    end
    final_url
  end
end
