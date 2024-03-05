class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_response 

    def not_found_response
        render json: { error: 'Sorry, your credentials are bad!' }, status: :unauthorized
    end

    # AR helpers

    def find_user_by_email(email)
        if user = User.find_by(email: email)
            user
        else
            raise ActiveRecord::RecordNotFound
        end
    end

    def find_user_by_api_key(api_key)
        if user = User.find_by(api_key: api_key)
            user
        else
            raise ActiveRecord::RecordNotFound
        end
    end
end
