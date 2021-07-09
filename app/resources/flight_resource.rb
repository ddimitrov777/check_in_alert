class FlightResource < ApplicationResource
  attribute :id, :integer, writable: false
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false
  attribute :user_id, :integer
  attribute :departs_at, :datetime
  attribute :description, :string
  attribute :alert_sent, :boolean

  # Direct associations

  belongs_to :user

  # Indirect associations
end
