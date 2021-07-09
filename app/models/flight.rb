class Flight < ApplicationRecord
  # Direct associations

  belongs_to :user

  # Indirect associations

  # Validations

  validates :departs_at, :presence => true

  # Scopes

  def to_s
    user.to_s
  end

end
