class RecipeSerializer
    include JSONAPI::Serializer

    # set_id "null"
    set_type "recipe"
    attributes :title, :url, :country, :image
end