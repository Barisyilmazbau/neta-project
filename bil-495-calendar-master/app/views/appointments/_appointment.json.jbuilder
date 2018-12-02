json.extract! appointment, :id, :description, :date, :recursive, :recurseDays, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
