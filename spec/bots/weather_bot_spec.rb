require './bots/weather_bot'
require 'dotenv'
Dotenv.load

RSpec.describe WeatherBot do
  context '/weather' do
    before do
      allow(RestClient).to receive(:get).and_return 'some_json'
      allow(JSON).to receive(:parse)
        .and_return(
          'main' => { 'temp' => 10.1234 },
          'weather' => [{ 'main' => 'Sun' }]
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

    it 'returns the correct string' do
      expect(@wb.weather_description)
        .to eq 'Im wunderschoenen London sind es aktuell -263.0 Grad mit Sun'
    end
  end

  context '/forecast' do
    before do
      allow(RestClient).to receive(:get).and_return 'some_json'
      # rubocop:disable all
      allow(JSON).to receive(:parse)
        .and_return(
          { "list" => [
            {},
            {"dt" => 1459425600,"main" => {"temp" => 284.54,"temp_min":282.603,"temp_max":284.54,"pressure":1018.24,"sea_level":1028.31,"grnd_level":1018.24,"humidity":90,"temp_kf":1.94},"weather" => [{"id":801,"main" => "Clouds","description":"few clouds","icon":"02d"}],"clouds":{"all":24},"wind":{"speed":4.46,"deg":347.003},"sys":{"pod":"d"},"dt_txt":"2016-03-31 12:00:00"}
          ]}
        )
      # rubocop:enable all

      @wb = WeatherBot.new(%w(London uk))
      @api_key = ENV['OWM_KEY']
    end

    it 'calls the owm api' do
      base_url = 'api.openweathermap.org/data/2.5/forecast'
      expect(RestClient).to receive(:get)
        .with "#{base_url}?q=London,uk&appid=#{@api_key}"
      @wb.weather_forecast
    end

    it 'returns the correct string' do
      expect(@wb.weather_forecast)
        .to eq 'Im wunderschoenen London werden es 11.4 Grad mit Clouds'
    end
  end

  it 'calculates the temp and rounds correctly' do
    @wb = WeatherBot.new(%w(London uk))
    expect(@wb.send(:k_to_c, 10.1234)).to eq(-263.0)
  end
end
