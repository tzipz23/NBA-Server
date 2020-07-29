class UserJoinsController < ApplicationController
    
    def index
        render json: UserJoin.all, include: [:user]
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
    end

    def destroy
        unfriend = UserJoin.find(params[:id])
        unfriend.destroy
        render json: unfriend
    end

end


