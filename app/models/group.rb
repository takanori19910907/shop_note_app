class Group < ApplicationRecord
  has_many :group_members, dependent: :destroy
  has_many :users, through: :group_members
  has_many :notes, dependent: :destroy
  has_many :favorite_items, dependent: :destroy
  accepts_nested_attributes_for :group_members

  validates :name, presence: true, length: { maximum: 20 }
  validates :admin_user_id, presence: true
  validates :profile, length: { maximum: 100 }

  mount_uploader :image, ImageUploader
end
