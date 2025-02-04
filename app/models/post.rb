class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, length: { maximum: 2200 }
  mount_uploader :post_image, PostImageUploader
  serialize :post_image, JSON # SQLite
  acts_as_votable
end
