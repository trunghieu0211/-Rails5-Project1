class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  before_save {email.downcase!}
  scope :user_desc, ->{order(created_at: :desc)}

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
   foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
   foreign_key: "followed_id", dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: {maximum: Settings.user.max_name_size}
  validates :email, presence: true, length: {maximum: Settings.user.max_email_size},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.user.min_password_size}

  has_secure_password

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete(other_user)
  end

  def following? other_user
    following.include?(other_user)
  end

  class << self
    def count_follower
      joins(:followers).group("users.id").count.sort_by {|key, value| value}.reverse.first(5)
    end

    def hot_user
      User.find User.count_follower.transpose[0]
    end
  end
end
