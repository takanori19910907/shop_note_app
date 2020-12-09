class CreateGroupMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :group_members do |t|
      t.references :group,   null: false, foreign_key: true
      t.references :user,    null: false, foreign_key: true
      t.boolean :activated,  default: false
      t.timestamps           null: false
    end
  end
end
