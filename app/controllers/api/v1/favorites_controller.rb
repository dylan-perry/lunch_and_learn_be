class Api::V1::FavoritesController < ApplicationController

    # POST /api/v1/favorites
    def create
        user = User.find_by(api_key: params[:api_key])

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