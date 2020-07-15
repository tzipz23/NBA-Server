class InteractionsController < ApplicationController

    before_action :authorize_request

    def index
      
      
    end
  
    def show
    end
  
    def update
    end
  
    def create
    
  
    end
  
    def destroy
    end
  
    private
  
    def comment_params(*args)
      params.require(:comment).permit(*args)
    end
  
  end
  
end
