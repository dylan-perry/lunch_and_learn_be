class RestCountryService
    def conn
        Faraday.new(url: "https://restcountries.com/v3.1")
    end

    def get_url(url)
        response = conn.get(url)
        JSON.parse(response.body, symbolize_names: true)
    end
    
    def get_random_country
        names = get_url("https://restcountries.com/v3.1/all?fields=name")
        names.sample[:name][:common]
    end

    def get_capital_latlon_by_country(country)
        country_results = get_url("https://restcountries.com/v3.1/name/#{country}")
        country_results.map do |result|
            if result[:name][:common].downcase == country.downcase
                @latlon = {lat: result[:latlng][0], lon: result[:latlng][1]}
            end
        end
        @latlon
    end
end
