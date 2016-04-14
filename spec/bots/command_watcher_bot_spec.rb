require './bots/command_watcher_bot'

RSpec.describe CommandWatcherBot do
  it 'has a /start command' do
    cwb = CommandWatcherBot.new(text: '/start me up')
    expect(cwb.check_all).to eq 'tweap bot meldet sich zum Dienst!'
  end

  it 'has a /help command' do
    cwb = CommandWatcherBot.new(text: '/help me up')
    expect(cwb.check_all).to eq(
      <<-HEREDOC
        I know the following:
        /swag
        /weather or /w city(default=Berlin) country_code(default=de)
        /forecast or /fc city(default=Berlin) country_code(default=de) [today|tomorrow]
      HEREDOC
    )
  end

  it 'has a /swag command' do
    cwb = CommandWatcherBot.new(text: '/swag me up')
    expect(cwb.check_all).to eq 'yolo swag'
  end

  ['/weather me up', '/w me up'].each do |text|
    it "has a #{text.split[0]} command" do
      allow(WeatherBot).to receive(:new).and_return wb = double
      allow(wb).to receive(:weather_description)
      cwb = CommandWatcherBot.new(text: text)
      expect(WeatherBot).to receive(:new).with(%w(me up))
      expect(wb).to receive(:weather_description)
      cwb.check_all
    end
  end

  ['/forecast me up', '/fc me up'].each do |text|
    it "has a #{text.split[0]} command" do
      allow(WeatherBot).to receive(:new).and_return wb = double
      allow(wb).to receive(:weather_forecast)
      cwb = CommandWatcherBot.new(text: text)
      expect(WeatherBot).to receive(:new).with(%w(me up))
      expect(wb).to receive(:weather_forecast)
      cwb.check_all
    end
  end
end
