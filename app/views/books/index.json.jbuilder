json.array!(@books) do |book|
  json.extract! book, :id, :title, :description, :author, :is_borrowed
  json.url book_url(book, format: :json)
end
