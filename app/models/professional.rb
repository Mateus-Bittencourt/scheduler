class Professional < ApplicationRecord
  has_many :appointments
  has_many :users, through: :appointments

  validates :time_zone, presence: true, inclusion: {
                          in: TZInfo::Timezone.all_identifiers,
                          message: "%{value} is not a valid time zone",
                        }
end
