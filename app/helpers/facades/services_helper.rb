module Facades::ServicesHelper

    def process_country_for_services(country)
        if country
            country.delete(" ")
        else
            service = prepare_service_rest_country
            service.get_random_country.delete(" ")
        end
    end

    def prepare_service_edamam
        EdamamService.new
    end

    def prepare_service_rest_country
        RestCountryService.new
    end

    def prepare_service_youtube
        YoutubeService.new
    end

    def prepare_service_unsplash
        UnsplashService.new
    end

    def prepare_service_open_weather
        OpenWeatherService.new
    end
end