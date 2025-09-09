# app/services/open_weather_client.rb
require "net/http"
require "uri"
require "json"

class OpenWeatherClient
  BASE = "https://api.openweathermap.org/"

  def initialize(api_key)
    @api_key = api_key
  end

  # Geocoding for zip(MX)
  # https://openweathermap.org/api/geocoding-api#direct_zip
  def geocoding_zip(zip, country: "MX")
    uri = URI.parse("#{BASE}/geo/1.0/zip")
    uri.query = URI.encode_www_form(zip: "#{zip},#{country}", appid: @api_key)

    json_get(uri)
  end

  # 2) Clima actual por lat/lon
  # https://openweathermap.org/current
  def current_weather(lat:, lon:, lang: "es", units: "metric")
    uri = URI.parse("#{BASE}/data/2.5/weather")
    uri.query = URI.encode_www_form(lat: lat, lon: lon, lang: lang, units: units, appid: @api_key)

    json_get(uri)
  end

  private

  def json_get(uri)
    res = Net::HTTP.get_response(uri)

    return nil if res.is_a?(Net::HTTPNotFound) || res.code == "400"
    raise StandardError, "HTTP #{res.code}" unless res.is_a?(Net::HTTPSuccess)
    
    JSON.parse(res.body)
  end
end