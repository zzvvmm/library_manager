class AddBorrowedByToBooks < ActiveRecord::Migration[5.1]
  def change
    add_reference :books, :user, index: true, foreign_key: true
  end
end
