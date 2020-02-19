class Contact < ApplicationRecord
  scope :friends,   -> { where(type: 'Friend') }    # Contact.friends
  scope :emergency, -> { where(type: 'Emergency') } # Contact.emergencies
end
