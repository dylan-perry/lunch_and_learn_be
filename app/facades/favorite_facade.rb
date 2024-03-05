class FavoriteFacade < ApplicationFacade

    def initialize(user)
        @user = user
    end

    def favorites_by_user
        favorites = []
        @user.favorites.each do |favorite|
            favorites << FavoritePoro.new(favorite)
        end
        favorites
    end
end