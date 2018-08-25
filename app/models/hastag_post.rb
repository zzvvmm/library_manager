class HastagPost < ApplicationRecord
  belongs_to :hastag, counter_cache: :reviews_count
  belongs_to :review
end
