class User < ApplicationRecord
  has_many :appointments
  has_many :professionals, through: :appointments
end
