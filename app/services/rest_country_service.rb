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
end
