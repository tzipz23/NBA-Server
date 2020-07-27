class UserArticlesController < ApplicationController

    def index
        render json: UserArticle.all.as_json(include: [:user])
    end

    def show
        article = UserArticle.find(params[:id])
        render json     article.as_json(include: [:user])
    end

    def create
        article = UserArticle.create(user_articles)
        render json     article.as_json(include: [:user])
    end

    def destroy
        article = UserArticle.find(params[:id])
        article.destroy
        render json: article
    end

    private

    def user_ariticles
        params.require(:user_article).permit(:author, :content, :description, :published_at, :title, :url, :urlToImage, :user_id)
    end
    
end
