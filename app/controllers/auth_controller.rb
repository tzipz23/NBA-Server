class AuthController < ApplicationController

    # before_action :authorize_request

    def validate_token
        
        token = request.headers["Authenticate"]
        user = User.find(decode(token)["user_id"])
        
        render json: user
        # render json: {user_id: @current_user.id}, status: :ok
    end

    # def token_authenticate
    #     token = request.headers["Authenticate"]
    #     user = User.find(decode(token)["user_id"])
    #     render json: user
    # end

end
