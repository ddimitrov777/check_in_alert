json.extract! flight, :id, :user_id, :departs_at, :description, :alert_sent, :created_at, :updated_at
json.url flight_url(flight, format: :json)
