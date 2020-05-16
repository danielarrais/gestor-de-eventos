json.extract! event_request, :id, :created_at, :updated_at
json.url event_request_url(event_request, format: :json)
