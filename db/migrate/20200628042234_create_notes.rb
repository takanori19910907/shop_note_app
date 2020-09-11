class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.text :content
      t.string :image
      t.integer :count
      t.integer :user_id, null: false
      t.integer :group_id
      t.timestamps null: false
    end
    add_index :notes, %i[user_id created_at]
  end
end
