json.array!(@books) do |book|
  json.extract! book, :id, :name, :author, :edition, :state, :contact_name, :contact_phone, :price, :photo_url, :thumb_url, :created_at
  json.url book_url(book, format: :json)
end
