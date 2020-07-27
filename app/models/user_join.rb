class UserJoin < ApplicationRecord

    belongs_to :user

    belongs_to :follow, :class_name => ‘User’,
    :foreign_key => ‘followed_id’
    belongs_to :follower, :class_name => ‘User’,
    :foreign_key => ‘follower_id’

end
