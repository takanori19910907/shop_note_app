class CreateFavoriteItems < ActiveRecord::Migration[5.1]
  def change
    create_table :favorite_items do |t|
      t.string :name,        null: false
      t.references :user,    foreign_key: true
      t.references :group,   foreign_key: true
      t.timestamp            null: false
    end
  end
end
