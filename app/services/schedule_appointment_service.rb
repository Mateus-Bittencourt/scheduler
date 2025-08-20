class ScheduleAppointmentService
  Result = Struct.new(:success?, :data, :error)

  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  def call
    @appointment = @current_user.appointments.new(@params)

    if @appointment.save
      Result.new(true, @appointment, nil)
    else
        Result.new(false, nil, @appointment.errors.full_messages)
    end
rescue StandardError => e
    debugger
    Rails.logger.error("\n\nError in ScheduleAppointmentService:\n#{e.message}\n\n")
    Result.new(false, nil, ["An error occurred while creating the appointment."])
  end
end
