class CreateBooksCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :books_categories do |t|
      t.belongs_to :book, index: true
      t.belongs_to :category, index: true
      t.timestamps
    end
  end
end
