class Note < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  has_many :comments, dependent: :destroy
  has_many :own_comments, class_name: 'Comment', foreign_key: :note_id

  validates :user_id, presence: true
  validates :content, presence: true, unless: :has_imageData?, length: { maximum: 30 }

  mount_uploader :image, ImageUploader

  private
  #画像のみの投稿を有効にするため、contentが空かつimageがあるときにバリデーションを回避する
  def has_imageData?
    content == "" && image.present?
  end
end
