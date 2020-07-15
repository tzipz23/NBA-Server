class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.string :title
      t.string :snippet
      t.string :url

      t.timestamps
    end
  end
end
