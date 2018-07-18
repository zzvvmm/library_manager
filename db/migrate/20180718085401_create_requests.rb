class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.belongs_to :book, index: true
      t.belongs_to :user, index: true
      t.datetime :borrow_time
      t.datetime :return_time
      t.boolean :accepted

      t.timestamps
    end
  end
end
