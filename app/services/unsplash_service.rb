class UnsplashService
    def conn
        Faraday.new(url: "https://api.unsplash.com/photos") do |faraday|
            faraday.params["client_id"] = Rails.application.credentials.unsplash[:key]
            faraday.headers["Accept"] = "application/json"
            faraday.headers["Accept-Version"] = "v1"
        end
    end

    def get_url(url)
        response = conn.get(url)
        JSON.parse(response.body, symbolize_names: true)
    end
    
    def get_images_by_country(country)
        get_url("https://api.unsplash.com/search/photos?query=#{country}&per_page=10")[:results]
    end
end
