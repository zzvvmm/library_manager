class CreateBorrowings < ActiveRecord::Migration[5.1]
  def change
    create_table :borrowings do |t|

      t.timestamps
    end
  end
end
