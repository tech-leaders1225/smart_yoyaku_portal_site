json.array!(@events) do |event|
  json.extract! event, :id, :title, :body
  json.start event.start_date
end