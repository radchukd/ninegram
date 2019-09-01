class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :avatar, AvatarUploader
  serialize :avatar, JSON # SQLite
  validates :nickname, presence: true, length: { maximum: 30 }
  validates :bio, length: { maximum: 150 }
  has_many :posts, dependent: :destroy
  before_save :downcase_fields

private
  
  def downcase_fields
    self.nickname.downcase!
  end
end
