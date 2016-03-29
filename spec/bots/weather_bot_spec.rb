require './bots/weather_bot'
require 'dotenv'
Dotenv.load

RSpec.describe WeatherBot do
  before do
    allow(RestClient).to receive(:get).and_return 'some_json'
    allow(JSON).to receive(:parse)
      .and_return(
        'main' => { 'temp' => 10.1234 },
        'wind' => { 'speed' => 11 }
      )

    @wb = WeatherBot.new(%w(London uk))
    @api_key = ENV['OWM_KEY']
  end

  it 'calls the owm api' do
    base_url = 'api.openweathermap.org/data/2.5/weather'
    expect(RestClient).to receive(:get)
      .with "#{base_url}?q=London,uk&appid=#{@api_key}"
    @wb.weather_description
  end

  it 'calculates the temp and rounds correctly' do
    expect(@wb.send(:k_to_c, 10.1234)).to eq(-263.0)
  end

  it 'returns the correct string' do
    expect(@wb.weather_description)
      .to eq 'Im wunderschoenen London sind es aktuell -263.0 Grad'
  end
end
