class Book < ApplicationRecord
  has_many :books_categories
  has_many :categories, through: :books_categories
  has_many :requests
  has_many :users, through: :requests

  def find_request user_id
    @request = Request.find_by user_id: user_id
  end
end
