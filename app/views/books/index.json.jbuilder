json.array!(@books) do |book|
  json.extract! book, :id, :name, :author, :edition, :state, :email, :contact_name, :validation_code, :contact_phone
  json.url book_url(book, format: :json)
end
