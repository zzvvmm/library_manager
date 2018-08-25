class Chatroom < ApplicationRecord
  belongs_to :trip, foreign_key: "slug"

  has_many :messages, dependent: :destroy
  has_many :users, through: :messages

  validates :topic, presence: true, uniqueness: true, case_sensitive: false
end
