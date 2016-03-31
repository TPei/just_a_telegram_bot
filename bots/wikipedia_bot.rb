require 'rest-client'

class WikipediaBot
  def initialize(args)
  end

  def check
    url = 'https://en.wikipedia.org/wiki/Special:Random'
    final_url = ''
    RestClient.get(:url => url, :verify_ssl => false){ |response, request, result, &block|
      require 'pry'
      binding.pry
      if [301, 302, 307].include? response.code
        response.follow_redirection(request, result, &block)
      else
        final_url = request.url
      end
    }
    final_url
  end
end
