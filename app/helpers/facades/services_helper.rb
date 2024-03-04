module Facades::ServicesHelper

    def country_valid?(country)
        service = prepare_service_rest_country
        validity_result = service.check_country_valid?(country)
    end
    
    def process_country_for_services(country)
        if country
            country
        else
            service = prepare_service_rest_country
            service.get_random_country
        end
    end

    def prepare_service_edamam
        EdamamService.new
    end

    def prepare_service_rest_country
        RestCountryService.new
    end

    def prepare_service_youtubee
        YoutubeService.new
    end

    def prepare_service_unsplash
        UnsplashService.new
    end

    def prepare_service_open_weather
        OpenWeatherService.new
    end
end