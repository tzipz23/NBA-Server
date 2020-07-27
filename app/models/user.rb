class User < ApplicationRecord

    has_secure_password
    has_many :user_articles
    has_many :user_joins

    has_many :articles, through: :user_articles
    # has_many :commments, through: :articles
    has_many :interactions
    has_many :user_players, dependent: :destroy
    has_many :players, through: :user_players
    has_many :user_teams, dependent: :destroy
    has_many :teams, through: :user_teams

    has_many :keywords

    mount_uploader :avatar, AvatarUploader

    has_many :followed, :class_name => 'UserJoin', 
    :foreign_key => 'follower_id'
    has_many :followers, :class_name => 'UserJoin', 
    :foreign_key => 'followed_id'

    def self.check_user(credentials)
        @user = self.find_by(user_name: credentials[:username]).try(:authenticate, credentials[:password])
           
    end
    
    def self.encode(user)
        
        issued = Time.now.to_i
        expiration_delay = Time.now.to_i + (2 * 3600) # expiration after 3600s (times) hours
    
        payload = {
          username: user[:user_name],
          sub: user[:id],
          iat: issued,
          exp: expiration_delay
                  } 
        
        token = JWT.encode payload, 'my_super_secret_mod_4', 'HS256', { typ: 'JWT'}
        return token
      end
    
      def self.decode(token)
        decoded = JWT.decode(token, 'my_super_secret_mod_4')[0]
        HashWithIndifferentAccess.new decoded
      end


end
