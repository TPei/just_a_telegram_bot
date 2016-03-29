require './bots/command_watcher_bot'

RSpec.describe CommandWatcherBot do
  it 'has a /start command' do
    cwb = CommandWatcherBot.new(text: '/start me up')
    expect(cwb.check_all).to eq 'tweap bot meldet sich zum Dienst!'
  end

  it 'has a /help command' do
    cwb = CommandWatcherBot.new(text: '/help me up')
    expect(cwb.check_all).to eq(
      'I know /swag and /weather city(default=Berlin) country_code(default=de)'
    )
  end

  it 'has a /swag command' do
    cwb = CommandWatcherBot.new(text: '/swag me up')
    expect(cwb.check_all).to eq 'yolo swag'
  end

  it 'has a /weather command' do
    allow(WeatherBot).to receive(:new).and_return wb = double
    allow(wb).to receive(:weather_description)
    cwb = CommandWatcherBot.new(text: '/weather me up')
    expect(WeatherBot).to receive(:new).with(%w(me up))
    cwb.check_all
  end
end
