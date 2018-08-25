class Place < ApplicationRecord
  has_many :trips, foreign_key: "destination_id"
  has_many :plants, dependent: :destroy
  has_many :trips, through: :plants
end
