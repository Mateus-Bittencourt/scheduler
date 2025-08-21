class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :professional

  APPOINTMENT_DURATION = 30.minutes

  validates :start_time, presence: true
  validate :validate_all_rules_on_create, on: :create

  private

  def validate_all_rules_on_create
    return unless professional&.time_zone && start_time

    local_start_time = start_time.in_time_zone(professional.time_zone)

    if local_start_time < Time.current
      errors.add(:start_time, "can't be a past time or date")
      return
    end

    unless [0, 30].include?(local_start_time.min)
      errors.add(:start_time, "must be at a 30-minute interval (e.g., 09:00, 09:30).")
    end

    unless local_start_time.hour >= 9 && local_start_time.hour < 17
      errors.add(:start_time, "must be between 09:00 and 16:30.")
    end

    if local_start_time.on_weekend?
      errors.add(:start_time, "can't be on a weekend.")
    end

    return unless professional

    end_time = start_time + APPOINTMENT_DURATION
    overlapping_appointments = professional
      .appointments
      .where(start_time: start_time...end_time)

    if overlapping_appointments.exists?
      errors.add(:base, "Professional is not available at this time.")
    end
  end
end
