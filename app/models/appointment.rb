class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :professional

  validates :start_time, presence: true
  validates :user_id, presence: true
  validates :professional_id, presence: true

  validate :validate_availability_rules, on: :create

  private

  def validate_availability_rules
    return if start_time.blank?

    unless [0, 30].include?(start_time.min)
      errors.add(:start_time, "must be at a 30-minute interval (e.g., 09:00, 09:30).")
    end

    unless start_time.hour >= 9 && (start_time + 30.minutes).hour <= 17
      errors.add(:start_time, "must be between 09:00 and 16:30.")
    end

    if start_time.saturday? || start_time.sunday?
      errors.add(:start_time, "can't be on a weekend.")
    end

    end_time = start_time + 30.minutes
    overlapping_appointments = professional.appointments.where(start_time: start_time...end_time)
    if overlapping_appointments.exists?
      errors.add(:base, "Professional is not available at this time.")
    end
  end
end
