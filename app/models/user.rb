class User < ApplicationRecord

    has_many :user_articles
    has_many :user_joins

    has_many :articles, through: :user_articles
    has_many :commments, through: :articles
    has_many :interactions, through: :commments

    has_many :keywords

    mount_uploader :avatar, AvatarUploader

   


end
