class Participation < ApplicationRecord
  belongs_to :trip
  belongs_to :user

  enum accepted: {send_request: 0, join_in: 1}
  scope :select_request, ->{send_request.order created_at: :DESC}
end
