class ArticlesController < ApplicationController

    before_action :authorize_request

  def index
    
    render json: Article.all
  end

  def show
  end

  def update
  end

  def create
    @article = Article.new(user_id: @current_user.id, 
                            title: params[:listing][:salary_is_predicted],
                            snippet: params[:listing][:title],
                            url: params[:listing][:company][:display_name],)

    if (@article.save)
      render json: {article: @article}, status: :ok
    else
      render json: {error: "Error: Did not save successfully"}, status: :unprocessable_entity
    end


  end

  def destroy
  end

  private

  def listing_params(*args)
    params.require(:listing).permit(*args)
  end

end
