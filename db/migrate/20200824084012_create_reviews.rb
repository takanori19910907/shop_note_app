class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :content, null: false
      t.integer :rate
      t.timestamps
    end
  end
end
