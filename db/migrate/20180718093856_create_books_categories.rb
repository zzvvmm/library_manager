class CreateBooksCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :books_categories, id: false do |t|
      t.belongs_to :books, index: true
      t.belongs_to :categories, index: true
    end
  end
end
