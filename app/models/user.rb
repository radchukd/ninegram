class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  mount_uploader :avatar, AvatarUploader
  serialize :avatar, JSON # SQLite

  validates :nickname, 
            presence: true, 
            length: { maximum: 30 }, 
            uniqueness: true

  validates :bio, length: { maximum: 150 }
  has_many :posts, dependent: :destroy
  before_save :downcase_fields

  has_many :active_relationships, 
           class_name: "Relationship",
           foreign_key: "follower_id",
           dependent: :destroy

  has_many :passive_relationships,
           class_name: "Relationship",
           foreign_key: "followed_id",
           dependent: :destroy

  has_many :following, 
           through: :active_relationships,
           source: :followed

  has_many :followers, 
           through: :passive_relationships,
           source: :follower

  acts_as_voter


  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  def following?(other_user)
    following.include?(other_user)
  end

private
  
  def downcase_fields
    self.nickname.downcase!
  end
end
