class UserPlayersController < ApplicationController
    
    def index
        render json: UserPlayer.all.as_json(include: [:user, :player => {include: [:team]}])
    end

    def show
        render json: UserPlayer.find_by(id: params[:id]).as_json(include: [:user, :player => {include: [:team]}])
    end

    def create
        user_player = UserPlayer.create(user_player_params)
        # byebug
        render json: user_player.as_json(include: [:user, :player => {include: [:team]}])
        
    end

    def destroy
        user_player = UserPlayer.find(params[:id])
        user_player.destroy
        render json: user_player
    end
    
    private

    def user_player_params
        params.require(:user_player).permit(:user_id, :player_id)
    end
end
