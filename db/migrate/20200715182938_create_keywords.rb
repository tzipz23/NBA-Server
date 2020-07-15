class CreateKeywords < ActiveRecord::Migration[6.0]
  def change
    create_table :keywords do |t|
      t.integer :user_id
      t.string :word

      t.timestamps
    end
  end
end
