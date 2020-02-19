class User < ApplicationRecord
  has_many :emergencies, class_name: 'Emergency'
  has_many :friends, class_name: 'Friend'
end
