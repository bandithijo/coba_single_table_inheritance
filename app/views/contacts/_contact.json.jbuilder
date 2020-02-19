json.extract! contact, :id, :user_id, :type, :first_name, :last_name, :phone_number, :address, :city, :state, :birthday, :created_at, :updated_at
json.url contact_url(contact, format: :json)
