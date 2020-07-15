class CreateInteractions < ActiveRecord::Migration[6.0]
  def change
    create_table :interactions do |t|
      t.integer :comment_id
      t.integer :user_id
      t.boolean :like

      t.timestamps
    end
  end
end
