class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :notes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :group_members
  has_many :groups, through: :group_members
  has_many :favorite_items, dependent: :destroy
  has_many :reviews

  mount_uploader :image, ImageUploader
end
