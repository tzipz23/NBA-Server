class UserJoinsController < ApplicationController
    
    def index
        render json: UserJoin.all
    end

    def create
        # byebug
        friend = UserJoin.create(follower_id: params[:follower_id], followed_id: params[:followed_id])
        if friend
            render json: friend, status: :ok
        else
            render json: { error: true, message: " unable to follow "}, status: :bad_request
        end
    end

    def show
        render json: UserJoin.find(params[:id])
    end

    def destroy
        unfriend = UserJoin.find_by(follower_id: params[:follower_id], followed_id: params[:followed_id])
        if unfriend.destroy
            render json: unfriend
        else
            render json: {error: true, message: "Unfollow unseccessful"}, status: 400
        end
        
    end

end


