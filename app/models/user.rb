class User < ApplicationRecord
  has_many :appointments
  has_many :professional, through: :appointments
end
