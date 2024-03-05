class Api::V1::FavoritesController < ApplicationController

    # GET /api/v1/favorites
    def index
        user = find_user_by_api_key(params[:api_key])

        results = FavoriteFacade.new(user).favorites_by_user
        render json: FavoriteSerializer.new(results)
    end
    
    # POST /api/v1/favorites
    def create
        user = find_user_by_api_key(params[:api_key])

        params[:user_id] = user.id # Adding favorite to user
        favorite = Favorite.new(favorite_params)

        if favorite.save
            render json: { success: "Favorite added successfully" }, status: :created
        else
            render json: favorite.errors, status: :bad_request
        end
    end

    private

    def favorite_params
        params.permit(:country, :recipe_link, :recipe_title, :user_id)
    end
end