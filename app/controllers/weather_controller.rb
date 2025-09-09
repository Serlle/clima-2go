class WeatherController < ApplicationController
  def new; end

  def create
    cp = params[:zip].to_s.strip

    if cp.blank?
      return redirect_to root_path, alert: "Por favor ingresa un código postal."
    end

    begin
      client = OpenWeatherClient.new(ENV["OPENWEATHER_API_KEY"])
      geo = client.geocoding_zip(cp) # { "lat"=>19.4326, "lon"=>-99.1332, "name"=>"Ciudad de México", "zip"=> "01000", "country"=>"MX" }

      unless geo.is_a?(Hash) && geo["lat"] && geo["lon"]
        return redirect_to root_path, alert: "Código postal no válido o no encontrado."
      end

      weather = client.current_weather(lat: geo["lat"], lon: geo["lon"])
      
      session[:resultado] = {
        "zip" => cp,
        "colonia" => geo["name"],
        "lat" => geo["lat"],
        "lon" => geo["lon"],
        "descripcion" => weather.dig("weather", 0, "description"),
        "temp" => weather.dig("main", "temp"),
        "feels_like" => weather.dig("main", "feels_like"),
        "amanecer" => Time.at(weather.dig("sys", "sunrise")).in_time_zone("America/Mexico_City").strftime("%H:%M"),
        "atardecer" => Time.at(weather.dig("sys", "sunset")),
        "tz_offset" => weather["timezone"]
      }

      redirect_to weather_show_path(id: "resultado")

    rescue => e
      Rails.logger.error(e.message)
      redirect_to root_path, alert: "Ocurrió un error al obtener los datos del clima. Intenta nuevamente."
    end

  end
  def show
    @data = session[:resultado]
    redirect_to root_path, alert: "Busca primero un codigo postal." if @data.blank?
  end
end
