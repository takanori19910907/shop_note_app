require 'nkf'

class FavoriteItem < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  validates :name, presence: true
end
