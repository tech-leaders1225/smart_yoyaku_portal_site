json.array!(@storemanagers) do |storemanager|
  json.start storemanager.id
  json.end storemanager.name
  json.url event_url(event, format: :html)
end