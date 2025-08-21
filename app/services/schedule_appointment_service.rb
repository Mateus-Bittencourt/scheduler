class ScheduleAppointmentService
  Result = Struct.new(:success?, :data, :error)

  def initialize(current_user, params)
    @current_user = current_user
    @params = params.respond_to?(:symbolize_keys) ? params.symbolize_keys : params
  end

  def call
    start_time_param = @params[:start_time]

    begin
      parsed_start_time = Time.iso8601(start_time_param)
    rescue
      error_message = "Invalid format for start_time. Please use ISO 8601 format (e.g., 'YYYY-MM-DDTHH:MM:SSZ' or 'YYYY-MM-DDTHH:MM:SS-03:00')."
      return Result.new(false, nil, error_message)
    end

    @appointment = @current_user.appointments.new(
      professional_id: @params[:professional_id],
      start_time: parsed_start_time
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
