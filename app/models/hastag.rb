class Hastag < ApplicationRecord
  has_many :hastag_posts, dependent: :destroy
  has_many :reviews, through: :hastag_posts

  validates :title, presence: true, uniqueness: {case_sensitive: false}

  scope :order_by_count,
    ->{order(reviews_count: :desc).limit(Settings.hastags.top)}
end
