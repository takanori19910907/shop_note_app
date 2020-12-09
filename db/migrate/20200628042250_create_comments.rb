class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :content,               null: false
      t.integer :user_id,            null: false
      t.integer :note_id,            null: false
      t.timestamps                   null: false
    end
  end
end
