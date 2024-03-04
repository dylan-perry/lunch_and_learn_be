class AirQualityFacade
    include Facades::ServicesHelper

    def initialize(country)
        if country_valid?(country) || country == nil
            @country = country
        else
            raise ActionController::BadRequest
        end
    end
    
    def air_quality_by_country
        country_query = process_country_for_services(@country)

        country_latlon = latlon_by_country(country_query)
        
        country_air_quality = air_quality_by_latlon(country_latlon)

        AirQualityPoro.new(country_air_quality)
    end

    def latlon_by_country(country)
        rest_country_service = prepare_service_rest_country
        latlon_result = rest_country_service.get_capital_latlon_by_country(country)
    end

    def air_quality_by_latlon(latlon)
        open_weather_service = prepare_service_open_weather
        air_quality_result = open_weather_service.get_air_quality_by_latlon(latlon)
    end
end