require 'rest-client'
require 'dotenv'
Dotenv.load

class WeatherBot
  BASE_URL = 'api.openweathermap.org/data/2.5/'.freeze
  DEFAULT_CITY = 'Berlin'.freeze
  DEFAULT_COUNTRY_CODE = 'de'.freeze

  def initialize(args)
    @city = args[0] || DEFAULT_CITY
    @country = args[1] || DEFAULT_COUNTRY_CODE
    @time = args[2] || 'today'
    @api_key = ENV['OWM_KEY']
  end

  def weather_description
    url = "#{BASE_URL}weather?q=#{@city},#{@country}&appid=#{@api_key}"
    response = parse(RestClient.get(url))
    celcius = k_to_c(response['main']['temp'])
    trait = response['weather'][0]['main']
    "Im wunderschoenen #{@city} sind es aktuell #{celcius} Grad mit #{trait}"
  end

  def weather_forecast
    url = "#{BASE_URL}forecast?q=#{@city},#{@country}&appid=#{@api_key}"
    response = parse(RestClient.get(url))
    response = response['list'][time_index]
    celcius = k_to_c(response['main']['temp'])
    trait = response['weather'][0]['main']
    "Im wunderschoenen #{@city} werden es #{@time} #{celcius} Grad mit #{trait}"
  end

  private

  def parse(json)
    JSON.parse(json)
  end

  def k_to_c(k)
    (k - 273.15).round(1)
  end

  def time_index
    case @time
    when 'today'
      1
    when 'tomorrow'
      8
    end
  end
end
