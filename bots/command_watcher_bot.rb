require './bots/weather_bot'
require './bots/wikipedia_bot'

class CommandWatcherBot
  def initialize(text:)
    @text = text
  end

  # rubocop:disable MethodLength
  def check_all
    args = @text.split(' ')
    case args.first
    when '/start'
      'tweap bot meldet sich zum Dienst!'
    when '/help'
      'I know /swag and /weather city(default=Berlin) country_code(default=de)'
    when '/swag'
      'yolo swag'
    when '/weather'
      WeatherBot.new(args[1..-1]).weather_description
    when '/wiki'
      WikipediaBot.new(args[1..-1]).check
    end
  end
  # rubocop:enable MethodLength
end
