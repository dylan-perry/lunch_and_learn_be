class RecipeFacade
    def initialize(country)
        @country = country
    end

    def process_country_for_services
        if @country
            @country_query = @country
        else
            service = prepare_service_rest_country
            @country_query = service.get_random_country
        end
    end

    def prepare_service_edamam
        EdamamService.new
    end

    def prepare_service_rest_country
        RestCountryService.new
    end
    
    def recipes_by_country
        process_country_for_services
        
        service = prepare_service_edamam
    
        results = service.get_recipes_by_country(@country_query)
        recipes = results[:hits].map do |recipe_data|
            RecipePoro.new(recipe_data, @country_query)
        end
    end
end