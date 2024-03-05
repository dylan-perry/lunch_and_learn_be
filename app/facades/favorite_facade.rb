class FavoriteFacade < ApplicationFacade

    def initialize(user)
        @user = user
    end

    def favorites_by_user
        @user.favorites.each do |favorite|
            FavoritePoro.new(favorite)
        end
    end
end