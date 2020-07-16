class UserController < ApplicationController

    before_action :authorize_request, except: [:create, :login]

    def index
    end
  
    def show
    end
  
    def create
      # byebug
      @user = User.new(first_name: params[:user][:first_name], last_name: params[:user][:last_name], user_name: params[:username], password: params[:password])
      if @user.save
          token = User.encode(@user)
          render json: {token: token, user_id: @user.id}, status: :created 
          # render json: @user, status: :created
      else
          render json: { errors: @user.errors.full_messages },
                  status: :unprocessable_entity
      end
  end
  
    def update
    end
  
    def destroy
    end
  
    def login
      
      creds  = {username: params[:username], password: params[:password]}
      # byebug
      @user = User.check_user(creds)
      
      if (@user) 
        token = User.encode(@user)
        render json: {token: token, user_id: @user.id}, status: :ok
        # let user in => send back an encrypted token that will persist in the client
      else
        # keep user out // error messages "invalid username and/or password"
        render json: {error: 'Invalid username and/or password'}, status: :unauthorized
      end
  
  
    end
  
  
    private
  
    def user_params(*args)
      params.require(:user).permit(*args)
  end

end
