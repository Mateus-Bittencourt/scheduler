class ScheduleAppointmentService
  Result = Struct.new(:success?, :data, :error)

  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  def call
    begin
      parsed_start_time = Time.iso8601(@params[:start_time])
    rescue
      error_message =
        "Invalid format for start_time. 
        Please use ISO 8601 format (e.g., 'YYYY-MM-DDTHH:MM:SSZ' or 'YYYY-MM-DDTHH:MM:SS-03:00')."
      Result.new(false, nil, error_message)
    end

    @appointment = @current_user.appointments.new(
      professional_id: @params[:professional_id],
      start_time: parsed_start_time,
    )

    if @appointment.save
      Result.new(true, @appointment, nil)
    else
      Result.new(false, nil, @appointment.errors.full_messages)
    end
  rescue StandardError => e
    Rails.logger.error("\n\nError in ScheduleAppointmentService:\n#{e.message}\n\n")
    Result.new(false, nil, ["An error occurred while creating the appointment."])
  end
end
