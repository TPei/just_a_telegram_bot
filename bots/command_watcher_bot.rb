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
        /weather or /w city(default=Berlin) country_code(default=de)
        /forecast or /fc city country_code [today|tomorrow]
      HEREDOC
    when '/swag'
      'yolo swag'
    when '/weather', '/w'
      WeatherBot.new(args[1..-1]).weather_description
    when '/forecast', '/fc'
      WeatherBot.new(args[1..-1]).weather_forecast
    end
  end
  # rubocop:enable MethodLength
end
