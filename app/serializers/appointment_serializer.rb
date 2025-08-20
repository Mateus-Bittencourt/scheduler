class AppointmentSerializer
  def self.render_many(appointments)
    appointments.map { |appointment| render(appointment) }
  end

  def self.render(appointment)
    {
      id: appointment.id,
      appointment_date: I18n.l(appointment.start_time.to_date, format: :default, locale: :en),
      appointment_time: I18n.l(appointment.start_time, format: :time_only, locale: :en),
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
