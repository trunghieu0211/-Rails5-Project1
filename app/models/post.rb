class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  scope :post_desc, ->{order(created_at: :desc)}

  validates :user_id, presence: true
  validates :title, presence: true
  validates :body, presence: true
end
