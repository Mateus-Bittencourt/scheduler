class ScheduleAppointmentService
  Result = Struct.new(:success?, :data, :error)

  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  def call
    @appointment = @current_user.appointments.new(@params)

    if @appointment.save
      mapped_data = map_appointment
      Result.new(true, mapped_data, nil)
    else
      Result.new(false, nil, @appointment.errors.full_messages)
    end
  rescue StandardError => e
    Rails.logger.error("\n\nError in ScheduleAppointmentService: #{e.message}\n\n")

    Result.new(false, nil, ["An error occurred while creating the appointment."])
  end

  private

  def map_appointment
    {
      id: @appointment.id,
      appointment_date: I18n.l(@appointment.start_time.to_date, format: :default, locale: :en),
      appointment_time: I18n.l(@appointment.start_time, format: :time_only, locale: :en),
      professional: {
        name: @appointment.professional.name,
        specialty: @appointment.professional.specialty,
      },
      user: {
        name: @appointment.user.name,
      },
    }
  end
end
