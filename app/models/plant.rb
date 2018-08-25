class Plant < ApplicationRecord
  belongs_to :trip
  belongs_to :place

  accepts_nested_attributes_for :place, reject_if: :all_blank
end
