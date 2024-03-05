class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_response 

    def not_found_response
        render json: { error: 'Sorry, your credentials are bad!' }, status: :unauthorized
    end
end
