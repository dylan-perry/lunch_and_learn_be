class OpenWeatherService
    def conn
        Faraday.new(url: "http://api.openweathermap.org/data/2.5") do |faraday|
            faraday.params["appid"] = Rails.application.credentials.air_quality[:key]
            faraday.headers['Accept'] = 'application/json'
        end
    end

    def get_url(url)
        response = conn.get(url)
        JSON.parse(response.body, symbolize_names: true)
    end
    
    def get_air_quality_by_latlon(latlon)
        result = get_url("http://api.openweathermap.org/data/2.5/air_pollution?lat=#{latlon[:lat]}&lon=#{latlon[:lon]}")[:list].first
        air_quality = { aqi: result[:main][:aqi], datetime: result[:dt] }
    end
end
