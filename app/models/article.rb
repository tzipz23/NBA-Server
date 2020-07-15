class Article < ApplicationRecord

    has_many :user_articles
    has_many :comments
    has_many :interactions, through: :comments
end
