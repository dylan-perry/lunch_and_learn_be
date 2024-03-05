class Api::V1::SessionsController < ApplicationController

    # POST /api/v1/sessions
    def create
        user = find_user_by_email(params[:email])

        if user && user.authenticate(params[:password])
            render json: UserSerializer.new(user)
        else
            raise ActiveRecord::RecordNotFound
        end
    end
end