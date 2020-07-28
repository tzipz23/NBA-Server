class UserController < ApplicationController

    # before_action :authorize_request, except: [:create, :login]

    def index
      render json: User.all.as_json(include: [:user_players, :user_teams, :user_articles])
      # render json: User.all

    #  users = User.all
    #     render json: users, include: [:user_players, :user_teams, :articles]
      # render json: User.all include: [:players]
    end
  
    def show
      # byebug
      render json: User.find_by(id: params[:id]).as_json(include: [:user_players, :user_teams, :articles])
    end
  
    def create
      # byebug
      @user = User.new(first_name: params[:user][:first_name], last_name: params[:user][:last_name], user_name: params[:username], image: params[:image], password: params[:password])
      if @user.save
          token = User.encode(@user)
          render json: {token: token, user: @user}, status: :created 
          # render json: @user, status: :created
      else
          render json: { errors: @user.errors.full_messages },
                  status: :unprocessable_entity
      end
  end
  
    def update
      user = User.find(params[:id])
      user.update( image: params[:image])
      render json: user
    end
  
    def destroy
      user = User.find(params[:id])
        user.destroy
        render json: user
    end
  
    def login
      
      creds  = {username: params[:username], password: params[:password]}
      # byebug
      @user = User.check_user(creds)
      
      if (@user) 
        payload = {user_id: @user.id}
        token = encode(payload)
        render json: {token: token, user: @user}, status: :ok
        # let user in => send back an encrypted token that will persist in the client
      else
        # keep user out // error messages "invalid username and/or password"
        render json: {error: 'Invalid username and/or password'}, status: :unauthorized
      end
  
  
    end

    def token_authenticate
      token = request.headers["Authenticate"]
      
      user = User.find(decode(token)["user_id"])
      render json: user
  end
  
  
    private
  
    def user_params(*args)
      params.require(:user).permit(*args)
  end

end
