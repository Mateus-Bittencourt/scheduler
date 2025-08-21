class AppointmentSerializer
  def self.render_many(appointments, time_zone: "UTC")
    appointments.map { |appointment| render(appointment, time_zone:) }
  end

  def self.render(appointment, time_zone: "UTC")
    local_time = appointment.start_time.in_time_zone(time_zone)

    {
      id: appointment.id,
      appointment_date: I18n.l(local_time.to_date, format: :default, locale: :en),
      appointment_time: I18n.l(local_time, format: :time_only, locale: :en),
      professional: {
        name: appointment.professional.name,
        specialty: appointment.professional.specialty,
      },
      user: {
              name: appointment.user.name,
            },
    }
  end
end
