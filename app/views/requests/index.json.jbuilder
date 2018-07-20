json.array!(@requests) do |request|
  json.extract! request, :id, :book_id, :borrow_time, :return_time, :user_id
  json.url request_url(request, format: :json)
end
