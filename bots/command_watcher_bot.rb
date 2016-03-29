require './bots/weather_bot'

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
      <<-HEREDOC
        I know the following:
        /swag
        /weather city(default=Berlin) country_code(default=de)
        /forecast city(default=Berlin) country_code(default=de)
      HEREDOC
    when '/swag'
      'yolo swag'
    when '/weather'
      WeatherBot.new(args[1..-1]).weather_description
    when '/forecast'
      WeatherBot.new(args[1..-1]).weather_forecast
    end
  end
  # rubocop:enable MethodLength
end
