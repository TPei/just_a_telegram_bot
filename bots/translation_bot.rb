require 'rest-client'
require 'dotenv'
Dotenv.load

class TranslationBot
  URL = 'https://translate.yandex.net/api/v1.5/tr.json/'.freeze
  DETECT = 'detect?'.freeze
  TRANSLATE = 'translate?'.freeze

  def initialize(text)
    @text = text
  end

  def translate
    api_key = ENV['YANDEX_KEY']
    response = JSON.parse(RestClient.get("#{URL}#{DETECT}&key=#{api_key}&text=#{@text}"))
    lang = response['lang']

    response = JSON.parse(RestClient.get("#{URL}#{TRANSLATE}&key=#{api_key}&text=#{@text}&lang=#{lang}-en"))
    response['text'][0]
  end
end
