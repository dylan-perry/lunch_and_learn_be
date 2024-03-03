class RecipeFacade
    include Facades::ServicesHelper

    def initialize(country)
        @country = country
    end

    def recipes_by_country
        country_query = process_country_for_services(@country)
        
        service = prepare_service_edamam
    
        results = service.get_recipes_by_country(country_query)
        recipes = results[:hits].map do |recipe_data|
            RecipePoro.new(recipe_data, country_query)
        end
    end
end