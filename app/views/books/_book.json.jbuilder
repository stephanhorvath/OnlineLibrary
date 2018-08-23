json.extract! book, :id, :title, :author, :description, :genre, :publisher, :supplier_id, :type, :created_at, :updated_at
json.url book_url(book, format: :json)
