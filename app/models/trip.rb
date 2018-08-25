class Trip < ApplicationRecord
  include PgSearch
  multisearchable :against => :name

  belongs_to :place, foreign_key: "destination_id"
  belongs_to :owner, class_name: User.name, foreign_key: :user_id

  has_one :chatroom, dependent: :destroy, foreign_key: "slug"

  has_many :participations, dependent: :destroy
  has_many :members, through: :participations,
    class_name: User.name, source: :user
  has_many :notifications
  has_many :plants
  has_many :places, through: :plants

  scope :per_page, ->{per Settings.paginate.per}

  pg_search_scope :search_trip, against: [:name],
    using: {tsearch: {any_word: true}}

  accepts_nested_attributes_for :place, reject_if: :all_blank

  validates :name, presence: true, uniqueness: {case_sensitive: false},
    length: {maximum: Settings.trip.name.maximum}
end
