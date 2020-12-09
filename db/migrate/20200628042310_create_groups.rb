class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :name,             null: false
      t.integer :admin_user_id,   null: false
      t.text :profile
      t.string :image
      t.timestamps                null: false
    end
  end
end
