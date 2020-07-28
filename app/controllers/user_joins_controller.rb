class UserJoinsController < ApplicationController
    
    def index
        render json: UserJoin.all.as_json(include: [:user])
    end

    def show
    end

    def destroy
    end

end


