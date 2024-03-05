class FavoritePoro
    attr_reader :id, :recipe_link, :recipe_title, :country, :created_at

    def initialize(favorite)
        @id = favorite[:id]
        @recipe_link = favorite[:recipe_link]
        @recipe_title = favorite[:recipe_link]
        @country = favorite[:country]
        @created_at = favorite[:created_at]
    end
end