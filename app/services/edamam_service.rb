class EdamamService < ApplicationService
    
    def conn
        Faraday.new(url: "https://api.edamam.com/api/recipes/v2") do |faraday|
            faraday.params["app_id"] = Rails.application.credentials.edamam[:app_id]
            faraday.params["app_key"] = Rails.application.credentials.edamam[:app_key]
        end
    end
    
    def get_recipes_by_country(country)
        get_url("https://api.edamam.com/api/recipes/v2?type=public&q=#{country}")
    end
end
