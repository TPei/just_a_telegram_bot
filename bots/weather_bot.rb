require 'rest-client'
require 'dotenv'
Dotenv.load

class WeatherBot
  BASE_URL = 'api.openweathermap.org/data/2.5/weather'.freeze
  DEFAULT_CITY = 'Berlin'.freeze
  DEFAULT_COUNTRY_CODE = 'de'.freeze

  def initialize(args)
    @city = args[0] || DEFAULT_CITY
    @country = args[1] || DEFAULT_COUNTRY_CODE
    @api_key = ENV['OWM_KEY']
  end

  def weather_description
    url = "#{BASE_URL}?q=#{@city},#{@country}&appid=#{@api_key}"
    response = parse(RestClient.get(url))
    celcius = k_to_c(response['main']['temp'])
    # wind_m_per_s = response['wind']['speed']
    "Im wunderschoenen #{@city} sind es aktuell #{celcius} Grad"
  end

  private

  def parse(json)
    JSON.parse(json)
  end

  def k_to_c(k)
    (k - 273.15).round(1)
  end
end
