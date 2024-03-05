class Api::V1::SessionsController < ApplicationController

    # POST /api/v1/sessions
    def create
        user = User.find_by(email: params[:email])

        if user && user.authenticate(params[:password])
            render json: UserSerializer.new(user)
        else
            raise ActiveRecord::RecordNotFound
        end
    end
end