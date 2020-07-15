class CreateUserJoins < ActiveRecord::Migration[6.0]
  def change
    create_table :user_joins do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
  end
end
