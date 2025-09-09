# app/services/open_weather_client.rb
require "net/http"
require "uri"
require "json"

class OpenWeatherClient
  BASE = "https://api.openweathermap.org/data/2.5/weather"

  def initialize(api_key)
    @api_key = api_key
  end

  # Geocoding for zip(MX)
  def geocoding_zip(zip, country: "MX")
    uri = URI.parse("#{BASE}/geo/1.0/zip") #duda
    uri.query = URI.encode_www_form(zip: "#{zip}", country: "#{country}", api: @api_key)

    json_get(uri)
  end

  def current_weather(lat:, lon:, lang: "es", units: "metric")
    uri = URI.parse("#{BASE}/data/2.5/weather")
    uri.query = URI.encode_www_form(lat: lat, lon: lon, lang: lang, units: units, appid: @api_key)

    json_get(uri)
  end

  private

  def json_get(uri)
    res = Net::HTTP.get_response(uri)
    raise StandardError, "HTTP #{res.code}" unless res.is_a?(Net::HTTPSuccess)
    JSON.parse(res.body)
  end
end