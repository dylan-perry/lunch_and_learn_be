class FavoriteSerializer
    include JSONAPI::Serializer

    set_type "favorite"
    attributes :recipe_link, :recipe_title, :country, :created_at
end