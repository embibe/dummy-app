json.array!(@entries) do |entry|
  json.extract! entry, :id, :entry
  json.url entry_url(entry, format: :json)
end
